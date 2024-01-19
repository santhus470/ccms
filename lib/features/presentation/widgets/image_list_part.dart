import 'dart:io';
import 'package:ccms/features/presentation/widgets/contaIner_heading.dart';
import 'package:ccms/providers/selected_imf_file_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../../../providers/image_selection_index_provider.dart';

/// when the user select some image or captuere image using the camera
/// this image list at the right side the of the windows with a deleted buttop
///  and that image is clickable
/// when the use click on one on the item in the list
/// the corresonding image will show .
/// on that window , the user  cam navigate, and zoom and delete tha image the same
///
class ImageListPArtWidget extends ConsumerStatefulWidget {
  const ImageListPArtWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImageListPArtWidgetState();
}

class _ImageListPArtWidgetState extends ConsumerState<ImageListPArtWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> paths = ref.watch(pickedFileListProvider);
    return Stack(
      children: [
        Container(
          color: Colors.white10,
          child: Column(
            children: [
              const ContainerHeadingWidget(title: 'Image List'),
              Expanded(
                  child: ListView.builder(
                itemCount: paths.length,
                itemBuilder: (context, index) {
                  if (paths.isNotEmpty) {
                    return Container(
                      color: Colors.black38,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              //set the selected image index ot the index on the path list
                              // then collect the image fom the selected path and show it
                              // in the model bottom sheet
                              ref
                                  .read(selectedImageIndexProvider.notifier)
                                  .setIndex(index);
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 50),
                                        Center(child: Consumer(
                                          builder: (context, ref, child) {
                                            return Container(
                                              color: Colors.black45,
                                              // decoration: BoxDecoration(
                                              //     border: Border.all(
                                              //         color: Colors.green)),
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  CloseButton(
                                                    color: Colors.white,
                                                  ),
                                                  //           ElevatedButton(
                                                  //   onPressed: () {
                                                  //     Navigator.of(context).pop();
                                                  //   },
                                                  //   child: const Text('Close'),
                                                  // ),
                                                  Text(paths[ref.watch(
                                                          selectedImageIndexProvider)]
                                                      .split('\\')
                                                      .last),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton.filled(
                                                          onPressed: ref.watch(
                                                                      selectedImageIndexProvider) !=
                                                                  0
                                                              ? () {
                                                                  ref
                                                                      .read(selectedImageIndexProvider
                                                                          .notifier)
                                                                      .decrement();
                                                                }
                                                              : null,
                                                          icon: const Icon(Icons
                                                              .arrow_back_ios)),
                                                      const SizedBox(width: 10),
                                                      InteractiveViewer(
                                                          maxScale: 5,
                                                          child: Image.file(
                                                            File(
                                                              paths[ref.watch(
                                                                  selectedImageIndexProvider)],
                                                            ),
                                                            width: 700,
                                                            height: 800,
                                                          )),
                                                      const SizedBox(width: 10),
                                                      // next button - implemetation
                                                      IconButton.filled(
                                                          onPressed: ref.read(
                                                                      selectedImageIndexProvider) <
                                                                  paths.length -
                                                                      1
                                                              ? () {
                                                                  ref
                                                                      .read(selectedImageIndexProvider
                                                                          .notifier)
                                                                      .increment();
                                                                }
                                                              : null,
                                                          icon: const Icon(Icons
                                                              .arrow_forward_ios))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.image),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(paths[index].split('\\').last)),
                                const SizedBox(width: 10),
                              ],
                            ),
                          )),
                          IconButton.filledTonal(
                              icon: const Icon(Icons.delete,
                                  size: 18, color: Colors.redAccent),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Alert'),
                                      content: const Text(
                                          'Do You want to delete the image..?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            ref
                                                .read(pickedFileListProvider
                                                    .notifier)
                                                .removeImage(ref.watch(
                                                    selectedImageIndexProvider));

                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              })
                        ],
                      ),
                    );
                  }
                },
              ))
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton.extended(
            heroTag: 'SvaveAll',
            onPressed: () {},
            label: const Text('Save All Images'),
            icon: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

// class ImgaeWidget extends ConsumerWidget {
//   const ImgaeWidget({
//     super.key,
//     required this.index,
//   });

//   final int index;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final String path = ref.watch(pickedFileListProvider)[index];
//     final int currentIndex = ref.watch(selectedImageIndexProvider);

//   }
// }
