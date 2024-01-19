import 'dart:io';
import 'package:ccms/features/presentation/widgets/img_edit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageEditPage extends ConsumerStatefulWidget {
  const ImageEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageEditPageState();
}

class _ImageEditPageState extends ConsumerState<ImageEditPage> {
  static const SizedBox sizedHeight = SizedBox(height: 20);

  static const double editContainrWidth = 250;
  static const List<int> thresholdItem = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuItem> menuItems = thresholdItem
    //     .map(
    //       (e) => DropdownMenuItem(
    //         child: Text(e.toString()),
    //         value: e,
    //         onTap: () {
    //           print(e);
    //         },
    //       ),
    //     )
    //     .toList();
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: const Text('1215/1/2025'),
      //   actions: const [CloseButtonIcon()],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('CREATE THE COPY',
                  style: Theme.of(context).textTheme.headlineSmall),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: editContainrWidth,
                child: Column(
                  children: [
                    Row(
                      children: [
                        EditBtnContainer(
                            ontap: () {},
                            icon: Icons.rotate_90_degrees_ccw,
                            lable: 'Rotate 90* left'),
                        EditBtnContainer(
                            ontap: () {
                              print('hai');
                            },
                            icon: Icons.rotate_90_degrees_cw,
                            lable: 'Rotate 90* right'),
                      ],
                    ),
                    // sizedHeight,
                    Row(
                      children: [
                        EditBtnContainer(
                            lable: 'Rotate 5* left', icon: Icons.rotate_left),
                        EditBtnContainer(
                            lable: 'Rotate 5* right',
                            ontap: () {},
                            icon: Icons.rotate_right)
                      ],
                    ),

                    Row(
                      children: [
                        EditBtnContainer(
                            lable: 'Crop box',
                            ontap: () {},
                            icon: Icons.crop_free),
                        EditBtnContainer(
                            lable: 'Free crop',
                            ontap: () {},
                            icon: Icons.polyline),
                      ],
                    ),

                    Row(
                      children: [
                        EditBtnContainer(
                            lable: 'Undo crop', ontap: () {}, icon: Icons.undo),
                        EditBtnContainer(
                            lable: 'redo crop', ontap: () {}, icon: Icons.redo),
                      ],
                    ),

                    Row(
                      children: [
                        EditBtnContainer(
                            lable: 'Previous Image',
                            ontap: () {},
                            icon: Icons.arrow_back_ios_new),
                        EditBtnContainer(
                            lable: 'Next Image',
                            ontap: () {},
                            icon: Icons.arrow_forward_ios)
                      ],
                    ),

                    Row(
                      children: [
                        EditBtnContainer(
                            lable: 'Edit Page Number',
                            ontap: () {},
                            icon: Icons.edit),
                        EditBtnContainer(
                          lable: 'Delete',
                          ontap: () {},
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    // Container(
                    //   color: Colors.white10,
                    //   child: Column(
                    //     children: [
                    //       Text('Set Parameters'),
                    //       // DropdownButton(
                    //       //     items: menuItems, onChanged: (value) {})
                    //     ],
                    //   ),
                    // )
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
