// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entities/document_model.dart';
import 'entities/image_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4142894129449721378),
      name: 'Document',
      lastPropertyId: const IdUid(10, 4109567542074041793),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6802889313992168944),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 4504688540076937807),
            name: 'numner',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3220232421305464271),
            name: 'year',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5499231604503128271),
            name: 'book',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8392339064695521842),
            name: 'isCaptureStarted',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5712510806812574820),
            name: 'isCatureCompleted',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 55171684222855545),
            name: 'isEditStarted',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3837316717598438516),
            name: 'isEditComoleted',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5087627045391276532),
            name: 'isPdfCreated',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 4109567542074041793),
            name: 'isUploaded',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(2, 3890172104611550167),
            name: 'images',
            targetId: const IdUid(2, 295145425915009118))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 295145425915009118),
      name: 'ImageModel',
      lastPropertyId: const IdUid(6, 6855874788568771681),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2919997779641551996),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1024054423254675974),
            name: 'rawPath',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4412888638781542557),
            name: 'processedPath',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5456954608447195392),
            name: 'isProcessed',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7842541415632044196),
            name: 'pageNo',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6855874788568771681),
            name: 'documentId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 5656647567838950994),
            relationTarget: 'Document')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 295145425915009118),
      lastIndexId: const IdUid(1, 5656647567838950994),
      lastRelationId: const IdUid(2, 3890172104611550167),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [5901218742424889778],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Document: EntityDefinition<Document>(
        model: _entities[0],
        toOneRelations: (Document object) => [],
        toManyRelations: (Document object) =>
            {RelInfo<Document>.toMany(2, object.id): object.images},
        getId: (Document object) => object.id,
        setId: (Document object, int id) {
          object.id = id;
        },
        objectToFB: (Document object, fb.Builder fbb) {
          final numnerOffset =
              object.numner == null ? null : fbb.writeString(object.numner!);
          final yearOffset =
              object.year == null ? null : fbb.writeString(object.year!);
          final bookOffset =
              object.book == null ? null : fbb.writeString(object.book!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, numnerOffset);
          fbb.addOffset(2, yearOffset);
          fbb.addOffset(3, bookOffset);
          fbb.addInt64(4, object.isCaptureStarted);
          fbb.addInt64(5, object.isCatureCompleted);
          fbb.addInt64(6, object.isEditStarted);
          fbb.addInt64(7, object.isEditComoleted);
          fbb.addInt64(8, object.isPdfCreated);
          fbb.addInt64(9, object.isUploaded);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final numnerParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final yearParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final bookParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final isCaptureStartedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final isCatureCompletedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final isEditStartedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final isEditComoletedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 18);
          final isPdfCreatedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 20);
          final isUploadedParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22);
          final object = Document(
              id: idParam,
              numner: numnerParam,
              year: yearParam,
              book: bookParam,
              isCaptureStarted: isCaptureStartedParam,
              isCatureCompleted: isCatureCompletedParam,
              isEditStarted: isEditStartedParam,
              isEditComoleted: isEditComoletedParam,
              isPdfCreated: isPdfCreatedParam,
              isUploaded: isUploadedParam);
          InternalToManyAccess.setRelInfo<Document>(
              object.images, store, RelInfo<Document>.toMany(2, object.id));
          return object;
        }),
    ImageModel: EntityDefinition<ImageModel>(
        model: _entities[1],
        toOneRelations: (ImageModel object) => [object.document],
        toManyRelations: (ImageModel object) => {},
        getId: (ImageModel object) => object.id,
        setId: (ImageModel object, int id) {
          object.id = id;
        },
        objectToFB: (ImageModel object, fb.Builder fbb) {
          final rawPathOffset =
              object.rawPath == null ? null : fbb.writeString(object.rawPath!);
          final processedPathOffset = object.processedPath == null
              ? null
              : fbb.writeString(object.processedPath!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, rawPathOffset);
          fbb.addOffset(2, processedPathOffset);
          fbb.addBool(3, object.isProcessed);
          fbb.addInt64(4, object.pageNo);
          fbb.addInt64(5, object.document.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final rawPathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final processedPathParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8);
          final isProcessedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
          final pageNoParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final object = ImageModel(
              id: idParam,
              rawPath: rawPathParam,
              processedPath: processedPathParam,
              isProcessed: isProcessedParam,
              pageNo: pageNoParam);
          object.document.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.document.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Document] entity fields to define ObjectBox queries.
class Document_ {
  /// see [Document.id]
  static final id = QueryIntegerProperty<Document>(_entities[0].properties[0]);

  /// see [Document.numner]
  static final numner =
      QueryStringProperty<Document>(_entities[0].properties[1]);

  /// see [Document.year]
  static final year = QueryStringProperty<Document>(_entities[0].properties[2]);

  /// see [Document.book]
  static final book = QueryStringProperty<Document>(_entities[0].properties[3]);

  /// see [Document.isCaptureStarted]
  static final isCaptureStarted =
      QueryIntegerProperty<Document>(_entities[0].properties[4]);

  /// see [Document.isCatureCompleted]
  static final isCatureCompleted =
      QueryIntegerProperty<Document>(_entities[0].properties[5]);

  /// see [Document.isEditStarted]
  static final isEditStarted =
      QueryIntegerProperty<Document>(_entities[0].properties[6]);

  /// see [Document.isEditComoleted]
  static final isEditComoleted =
      QueryIntegerProperty<Document>(_entities[0].properties[7]);

  /// see [Document.isPdfCreated]
  static final isPdfCreated =
      QueryIntegerProperty<Document>(_entities[0].properties[8]);

  /// see [Document.isUploaded]
  static final isUploaded =
      QueryIntegerProperty<Document>(_entities[0].properties[9]);

  /// see [Document.images]
  static final images =
      QueryRelationToMany<Document, ImageModel>(_entities[0].relations[0]);
}

/// [ImageModel] entity fields to define ObjectBox queries.
class ImageModel_ {
  /// see [ImageModel.id]
  static final id =
      QueryIntegerProperty<ImageModel>(_entities[1].properties[0]);

  /// see [ImageModel.rawPath]
  static final rawPath =
      QueryStringProperty<ImageModel>(_entities[1].properties[1]);

  /// see [ImageModel.processedPath]
  static final processedPath =
      QueryStringProperty<ImageModel>(_entities[1].properties[2]);

  /// see [ImageModel.isProcessed]
  static final isProcessed =
      QueryBooleanProperty<ImageModel>(_entities[1].properties[3]);

  /// see [ImageModel.pageNo]
  static final pageNo =
      QueryIntegerProperty<ImageModel>(_entities[1].properties[4]);

  /// see [ImageModel.document]
  static final document =
      QueryRelationToOne<ImageModel, Document>(_entities[1].properties[5]);
}
