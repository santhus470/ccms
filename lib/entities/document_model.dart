// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import 'package:ccms/entities/image_model.dart';

@Entity()
class Document {
  @Id(assignable: true)
  int id;
  final String? numner;
  final String? year;
  final String? book;
  final int? isCaptureStarted;
  final int? isCatureCompleted;
  final int? isEditStarted;
  final int? isEditComoleted;
  final int? isPdfCreated;
  final int? isUploaded;
  @BackButton()
  final images = ToMany<ImageModel>();
  Document({
    this.id = 0,
    required this.numner,
    required this.year,
    required this.book,
    this.isCaptureStarted = 0,
    this.isCatureCompleted = 0,
    this.isEditStarted = 0,
    this.isEditComoleted = 0,
    this.isPdfCreated = 0,
    this.isUploaded = 0,
  });

  @override
  String toString() {
    return ' $numner/$book/$year';
  }
}
