import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/services.dart';

class ImageCapturePart extends StatefulWidget {
  const ImageCapturePart({super.key});

  @override
  State<ImageCapturePart> createState() => _ImageCapturePartState();
}

class _ImageCapturePartState extends State<ImageCapturePart> {
  String _cameraInfo = 'Unknown';
  List<CameraDescription> cameras = <CameraDescription>[];
  int _cameraIndex = 1;
  int _cameraId = -1;
  bool _initialized = false;
  bool _recording = false;
  bool _recordingTimed = false;
  bool _recordAudio = true;
  bool _previewPaused = false;
  Size? _previewSize;
  ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    // List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = 1;
        cameraInfo = 'Found camera: ${cameras[0]}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = 1;
        cameras = cameras;
        _cameraInfo = cameraInfo;
      });
    }
  }

  /// Initializes the camera on the device.
  Future<void> _initializeCamera() async {
    assert(!_initialized);

    if (cameras.isEmpty) {
      return;
    }

    try {
      final CameraDescription camera = cameras[0];

      _cameraId = await CameraPlatform.instance.createCamera(
        camera,
        _resolutionPreset,
        enableAudio: _recordAudio,
      );

      unawaited(_errorStreamSubscription?.cancel());
      _errorStreamSubscription = CameraPlatform.instance
          .onCameraError(_cameraId)
          .listen(_onCameraError);

      unawaited(_cameraClosingStreamSubscription?.cancel());
      _cameraClosingStreamSubscription = CameraPlatform.instance
          .onCameraClosing(_cameraId)
          .listen(_onCameraClosing);

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(_cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        _cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _initialized = true;
          _cameraId = _cameraId;
          _cameraIndex = 1;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }
    } on CameraException catch (e) {
      try {
        if (_cameraId >= 0) {
          await CameraPlatform.instance.dispose(_cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;
          _recording = false;
          _recordingTimed = false;
          _cameraInfo =
              'Failed to initialize camera: ${e.code}: ${e.description}';
        });
      }
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
            _previewSize = null;
            _recording = false;
            _recordingTimed = false;
            _previewPaused = false;
            _cameraInfo = 'Camera disposed';
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          setState(() {
            _cameraInfo =
                'Failed to dispose camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Widget _buildPreview() {
    print(_cameraIndex);
    print('CameraId is $_cameraId');
    // _initialized = false;
    // _recording = false;
    // _recordingTimed = false;
    // _recordAudio = true;
    // _previewPaused = false;
    // _previewSize;
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  Future<void> _takePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
    _showInSnackBar('Picture captured to: ${file.path}');
  }

  Future<void> _recordTimed(int seconds) async {
    if (_initialized && _cameraId > 0 && !_recordingTimed) {
      unawaited(CameraPlatform.instance
          .onVideoRecordedEvent(_cameraId)
          .first
          .then((VideoRecordedEvent event) async {
        if (mounted) {
          setState(() {
            _recordingTimed = false;
          });

          _showInSnackBar('Video captured to: ${event.file.path}');
        }
      }));

      await CameraPlatform.instance.startVideoRecording(
        _cameraId,
        maxVideoDuration: Duration(seconds: seconds),
      );

      if (mounted) {
        setState(() {
          _recordingTimed = true;
        });
      }
    }
  }

  Future<void> _toggleRecord() async {
    if (_initialized && _cameraId > 0) {
      if (_recordingTimed) {
        /// Request to stop timed recording short.
        await CameraPlatform.instance.stopVideoRecording(_cameraId);
      } else {
        if (!_recording) {
          await CameraPlatform.instance.startVideoRecording(_cameraId);
        } else {
          final XFile file =
              await CameraPlatform.instance.stopVideoRecording(_cameraId);

          _showInSnackBar('Video captured to: ${file.path}');
        }

        if (mounted) {
          setState(() {
            _recording = !_recording;
          });
        }
      }
    }
  }

  Future<void> _togglePreview() async {
    if (_initialized && _cameraId >= 0) {
      if (!_previewPaused) {
        await CameraPlatform.instance.pausePreview(_cameraId);
      } else {
        await CameraPlatform.instance.resumePreview(_cameraId);
      }
      if (mounted) {
        setState(() {
          _previewPaused = !_previewPaused;
        });
      }
    }
  }

  Future<void> _switchCamera() async {
    if (cameras.isNotEmpty) {
      // select next index;

      if (_initialized && _cameraId >= 0) {
        await _disposeCurrentCamera();
        await _fetchCameras();
        if (cameras.isNotEmpty) {
          await _initializeCamera();
        }
      } else {
        await _fetchCameras();
      }
    }
  }

  Future<void> _onResolutionChange(ResolutionPreset newValue) async {
    setState(() {
      _resolutionPreset = newValue;
    });
    if (_initialized && _cameraId >= 0) {
      // Re-inits camera with new resolution preset.
      await _disposeCurrentCamera();
      await _initializeCamera();
    }
  }

  Future<void> _onAudioChange(bool recordAudio) async {
    setState(() {
      _recordAudio = recordAudio;
    });
    if (_initialized && _cameraId >= 0) {
      // Re-inits camera with new record audio setting.
      await _disposeCurrentCamera();
      await _initializeCamera();
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: ${event.description}')));

      // Dispose camera on camera error as it can not be used anymore.
      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      _showInSnackBar('Camera is closing');
    }
  }

  void _showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    print(_cameraIndex);

    final List<DropdownMenuItem<ResolutionPreset>> resolutionItems =
        ResolutionPreset.values
            .map<DropdownMenuItem<ResolutionPreset>>((ResolutionPreset value) {
      return DropdownMenuItem<ResolutionPreset>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(_cameraInfo),
        ),
        if (cameras.isEmpty)
          ElevatedButton(
            onPressed: _fetchCameras,
            child: const Text('Re-check available cameras'),
          ),
        if (cameras.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<ResolutionPreset>(
                value: _resolutionPreset,
                onChanged: (ResolutionPreset? value) {
                  if (value != null) {
                    _onResolutionChange(value);
                  }
                },
                items: resolutionItems,
              ),
              const SizedBox(width: 20),
              const Text('Audio:'),
              Switch(
                  value: _recordAudio,
                  onChanged: (bool state) => _onAudioChange(state)),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed:
                    _initialized ? _disposeCurrentCamera : _initializeCamera,
                child: Text(_initialized ? 'Dispose camera' : 'Create camera'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: _initialized ? _takePicture : null,
                child: const Text('Take picture'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: _initialized ? _togglePreview : null,
                child: Text(
                  _previewPaused ? 'Resume preview' : 'Pause preview',
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: _initialized ? _toggleRecord : null,
                child: Text(
                  (_recording || _recordingTimed)
                      ? 'Stop recording'
                      : 'Record Video',
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: (_initialized && !_recording && !_recordingTimed)
                    ? () => _recordTimed(5)
                    : null,
                child: const Text(
                  'Record 5 seconds',
                ),
              ),
              if (cameras.length > 1) ...<Widget>[
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _switchCamera,
                  child: const Text(
                    'Switch camera',
                  ),
                ),
              ]
            ],
          ),
        const SizedBox(height: 5),
        if (_initialized && _cameraId > 0 && _previewSize != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Align(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                ),
                child: AspectRatio(
                  aspectRatio: _previewSize!.width / _previewSize!.height,
                  child: _buildPreview(),
                ),
              ),
            ),
          ),
        if (_previewSize != null)
          Center(
            child: Text(
              'Preview size: ${_previewSize!.width.toStringAsFixed(0)}x${_previewSize!.height.toStringAsFixed(0)}',
            ),
          ),
      ],
    );
  }
}
