import 'package:ccms/entities/document_model.dart';
import 'package:ccms/providers/slected_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CapturedDocumentWidget extends ConsumerStatefulWidget {
  const CapturedDocumentWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CapturedDocumentWidgetState();
}

class _CapturedDocumentWidgetState
    extends ConsumerState<CapturedDocumentWidget> {
  @override
  Widget build(BuildContext context) {
    final Document doc = ref.watch(selectedDocumetProvider)!;
    return Container(
      color: Colors.greenAccent,
      child: Row(
        children: [
          Text(doc.numner!),
          const SizedBox(width: 10),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
        ],
      ),
    );
  }
}
