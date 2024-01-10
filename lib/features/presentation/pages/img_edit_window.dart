import 'dart:io';

import 'package:ccms/features/presentation/widgets/contaIner_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/selected_imf_file_path_provider.dart';

class ImageEditPage extends ConsumerStatefulWidget {
  const ImageEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends ConsumerState<ImageEditPage> {
  static const SizedBox sizedHeight = SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: const Text('1215/1/2025'),
      //   actions: const [CloseButtonIcon()],
      // ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Edit image and create copy',
                  style: Theme.of(context).textTheme.displaySmall),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.close,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 200,
                // decoration: const BoxDecoration(
                //   color: Colors.white12,
                // ),
                child: Column(
                  children: [
                    // const ContainerHeadingWidget(title: 'Editing Tools'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Rotate 90* left',
                            onPressed: () {},
                            icon: Icon(Icons.rotate_90_degrees_ccw)),
                        IconButton(
                            tooltip: 'Rotate 5* left',
                            onPressed: () {},
                            icon: const Icon(Icons.rotate_left)),
                      ],
                    ),
                    sizedHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Rotate 5* right',
                            onPressed: () {},
                            icon: const Icon(Icons.rotate_right)),
                        IconButton(
                            tooltip: 'Rotate 90* right',
                            onPressed: () {},
                            icon: Icon(Icons.rotate_90_degrees_cw))
                      ],
                    ),
                    sizedHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Crop box',
                            onPressed: () {},
                            icon: const Icon(Icons.crop_free)),
                        IconButton(
                            tooltip: 'Free crop',
                            onPressed: () {},
                            icon: const Icon(Icons.polyline)),
                      ],
                    ),
                    sizedHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Undo crop',
                            onPressed: () {},
                            icon: const Icon(Icons.undo)),
                        IconButton(
                            tooltip: 'redo crop',
                            onPressed: () {},
                            icon: const Icon(Icons.redo)),
                      ],
                    ),
                    sizedHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Previous Image',
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios_new)),
                        IconButton(
                            tooltip: 'Next Image',
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    sizedHeight,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            tooltip: 'Edit Page Number',
                            onPressed: () {},
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            tooltip: 'Delete',
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 250,
                height: MediaQuery.of(context).size.height - 200,
                color: Colors.red,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.file(File(
                        'C:\\Users\\DRO-24\\Pictures\\OYOOR20012022121244.png')),
                    Image.file(File(
                        'C:\\Users\\DRO-24\\Pictures\\OYOOR20012022121244_001.png')),
                  ],
                ),
              )
              // PageVis
            ],
          ),
        ],
      ),
    );
  }
}
