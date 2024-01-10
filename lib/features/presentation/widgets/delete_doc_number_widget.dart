import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/document_model.dart';
import '../../../main.dart';
import '../../../providers/doc_list_provider.dart';

class DocumentDeletionWidget extends ConsumerWidget {
  final Document document;
  const DocumentDeletionWidget({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String doc = '${document.numner}/${document.book}/${document.year}';
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Icon(
                Icons.info,
                color: Colors.redAccent,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Do you Want to delete the Document'),
                  Text(
                    '$doc  !',
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
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
                        .read(docAddProvider.notifier)
                        .removeDocument(document: document);
                    databox.delDocument(doc: document);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete,
        size: 18,
        color: Colors.red,
      ),
    );
  }
}
