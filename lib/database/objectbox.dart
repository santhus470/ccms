import 'dart:io';
import 'package:ccms/entities/document_model.dart';
import 'package:ccms/entities/image_model.dart';
import 'package:ccms/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class Databox {
  late final Store store;
  late final Box<Document> docBox;
  late final Box<ImageModel> imageBox;

  Databox._create(this.store) {
    docBox = Box<Document>(store);
    imageBox = Box<ImageModel>(store);
  }
  static Future<Databox> create() async {
    final docDir = await getApplicationSupportDirectory();

    final dbDir = Directory('${docDir.path}/ccmsdb/');
    print(dbDir);
    final store = await openStore(directory: dbDir.path);
    return Databox._create(store);
  }

  //document
  void addDocument({required Document doc}) {
    print('adding document');
    docBox.put(
      doc,
    );
  }

  void delDocument({required Document doc}) {
    docBox.remove(doc.id);
  }

  List<Document> getcaptureNotCompletedDocList() {
    final Query<Document> query =
        docBox.query(Document_.isCatureCompleted.equals(0)).build();
    return query.find();
  }

  List<Document> getAllDocument() {
    return docBox.getAll();
  }
}
