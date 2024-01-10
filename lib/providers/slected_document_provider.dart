import 'package:ccms/entities/document_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentNotifier extends StateNotifier<Document?> {
  DocumentNotifier() : super(null);

  void setDocumwnt(Document doc) {
    state = doc;
  }

  void setNull() {
    state = null;
  }
}

/// this provider provide the document number , selected for
/// either capturing or pick images form file.
/// [imgageCpatuing],[selectImageFromFile] use this provider to
/// watch fot the selection of document
final selectedDocumetProvider =
    StateNotifierProvider<DocumentNotifier, Document?>(
  (ref) => DocumentNotifier(),
);
