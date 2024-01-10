// import 'package:ccms/entities/document_model.dart';
// import 'package:ccms/features/presentation/widgets/delete_doc_number_widget.dart';
// import 'package:ccms/main.dart';
// import 'package:ccms/providers/doc_list_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../providers/slected_document_provider.dart';

// class DocumentNumberWidget extends ConsumerStatefulWidget {
//   final Document document;
//   const DocumentNumberWidget({
//     super.key,
//     required this.document,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _DocumentNumberWidgetState();
// }

// class _DocumentNumberWidgetState extends ConsumerState<DocumentNumberWidget> {
//   Color clr = Colors.black;
//   bool _isItemSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     // final String doc =
//         // '${widget.document.numner}/${widget.document.book}/${widget.document.year}';
//     final Document? currentItem = ref.read(selectedDocumetProvider);
//     return MouseRegion(
//       child: Container(
//           child: Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 if (currentItem != doc) {
//                   setState(() {
//                     _isItemSelected = true;
//                   });
//                 } else {
//                   print(currentItem);
//                 }
//                 ref.read(selectedDocumetProvider.notifier).setDocumwnt(doc);
//               },
//               child: Text(
//                 doc,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           const SizedBox(width: 20),
//         ],
//       )),
//     );
//   }
// }
