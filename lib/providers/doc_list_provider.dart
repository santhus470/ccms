import 'package:ccms/entities/document_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentAddNotifier extends StateNotifier<List<Document>> {
  DocumentAddNotifier() : super([]);
  void addDoc(Document doc) {
    state = [...state, doc];
  }

  void addListOfDoc(List<Document> docs) {
    state = [for (final doc in docs) doc];
  }

  void removeDocument({
    required Document document,
  }) {
    state = [
      for (final doc in state)
        if (doc.id != document.id) doc
    ];
  }
}

final docAddProvider =
    StateNotifierProvider<DocumentAddNotifier, List<Document>>(
        (ref) => DocumentAddNotifier());
