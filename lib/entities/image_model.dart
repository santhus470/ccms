// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:ccms/entities/document_model.dart';

@Entity()
class ImageModel {
  @Id()
  int id;
  final String? rawPath;
  final String? processedPath;
  final bool isProcessed;
  final int pageNo;
  final document = ToOne<Document>();
  ImageModel({
    this.id = 0,
    required this.rawPath,
    required this.processedPath,
    this.isProcessed = false,
    required this.pageNo,
  });
}
