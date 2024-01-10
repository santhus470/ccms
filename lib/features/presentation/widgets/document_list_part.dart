import 'package:ccms/entities/document_model.dart';
import 'package:ccms/features/presentation/widgets/contaIner_heading.dart';
import 'package:ccms/features/presentation/widgets/delete_doc_number_widget.dart';
import 'package:ccms/features/presentation/widgets/document_no_widget.dart';
import 'package:ccms/main.dart';
import 'package:ccms/providers/doc_list_provider.dart';
import 'package:ccms/providers/slected_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'document_collection_dialog_box.dart';

/// when initializing the widget it will check for any document alredy there in the
/// objectbox db in which the capturing is not completed
/// then  add these  collected document to the [docAddProvider] list
/// and watch for this[docAddProvider] for any new document added by the user
class DocumnetListPartWidget extends ConsumerStatefulWidget {
  const DocumnetListPartWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocumnetListPartWidgetState();
}

class _DocumnetListPartWidgetState
    extends ConsumerState<DocumnetListPartWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final List<Document> docs = databox.getAllDocument();
      ref.read(docAddProvider.notifier).addListOfDoc(docs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white12,
          ),
          child: Column(
            children: [
              const ContainerHeadingWidget(title: 'Documnets list'),
              Expanded(child: Consumer(
                builder: (context, ref, child) {
                  List<Document> docs = ref.watch(docAddProvider);
                  return ListView.builder(
                    itemCount: docs.length + 1,
                    itemBuilder: (context, index) {
                      if (index < docs.length) {
                        Document doc = docs[index];
                        // return DocumentNumberWidget(document: doc);
                        return DocumentNoWidget(doc: doc);
                      } else {
                        return const SizedBox(height: 75);
                      }
                    },
                  );
                },
              )),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const DocumentCollectionDialogBox();
                },
              );
            },
            label: const Text('Add'),
            icon: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class DocumentNoWidget extends ConsumerStatefulWidget {
  const DocumentNoWidget({
    super.key,
    required this.doc,
  });
  final Document doc;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocumentNoWidgetState();
}

class _DocumentNoWidgetState extends ConsumerState<DocumentNoWidget> {
  Color containerClr = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          containerClr = Colors.black54;
        });
      },
      onExit: (event) {
        setState(() {
          containerClr = Colors.black;
        });
      },
      child: InkWell(
        onTap: () {
          ref.read(selectedDocumetProvider.notifier).setDocumwnt(widget.doc);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.doc.isCaptureStarted == 1
                  ? Colors.green.shade900
                  : containerClr),
          child: Row(
            children: [
              Expanded(child: DocumentNumWidget(document: widget.doc)),
              const SizedBox(width: 15),
              DocumentDeletionWidget(document: widget.doc),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentNumWidget extends StatelessWidget {
  const DocumentNumWidget({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  Widget build(BuildContext context) {
    return Text(
      document.toString(),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
