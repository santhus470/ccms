import 'package:ccms/features/presentation/widgets/document_list_part.dart';
import 'package:ccms/features/presentation/widgets/image_capture_part_widget.dart';
import 'package:ccms/features/presentation/widgets/image_list_part.dart';
import 'package:flutter/material.dart';
import 'capture_completed_list.dart';

// import '../widgets/camera_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(border: Border.all(width: 5)),
        width: size.width,
        height: size.height,
        child: const Column(
          children: [
            // MuItemWidget(),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 2, child: DocumnetListPartWidget()),
                  Expanded(flex: 6, child: ImageCapturePartWidget()),
                  Expanded(flex: 2, child: ImageListPArtWidget()),
                  Expanded(flex: 1, child: CaptureCompletedDocList())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
