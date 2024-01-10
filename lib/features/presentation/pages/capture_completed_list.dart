import 'package:ccms/features/presentation/pages/img_edit_window.dart';
import 'package:ccms/features/presentation/widgets/contaIner_heading.dart';
import 'package:ccms/providers/selected_imf_file_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaptureCompletedDocList extends ConsumerStatefulWidget {
  const CaptureCompletedDocList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImageListPArtWidgetState();
}

class _ImageListPArtWidgetState extends ConsumerState<CaptureCompletedDocList> {
  @override
  Widget build(BuildContext context) {
    List<String> paths = ref.watch(pickedFileListProvider);
    return InkWell(
      child: Container(
        color: Colors.white24,
        child: Column(
          children: [
            const ContainerHeadingWidget(title: 'captured'),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageEditPage(),
                        ));
                      },
                      child: Icon(Icons.image_outlined))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
