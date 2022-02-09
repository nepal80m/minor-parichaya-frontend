import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/db_models/base_document_model.dart';
import '../models/db_models/document_image_model.dart';
import '../models/document_model.dart';

class DatabaseHelper {
  static final _databaseName = 'parichaya_DB.db';
  static final _databaseVersion = 1;

  static final documentTable = 'document_table';
  static final imageTable = 'image_table';

  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseHelper;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, _databaseName);

    return await openDatabase(path,
        onCreate: _onCreate, version: _databaseVersion);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $documentTable(id INTEGER PRIMARY KEY, title TEXT, note TEXT)',
    );
    await db.execute(
      'CREATE TABLE $imageTable(id INTEGER PRIMARY KEY, path TEXT,documentId INTEGER, FOREIGN KEY (documentId) REFERENCES document(id) ON DELETE CASCADE)',
    );
  }

  Future<int> insertDocument(BaseDocument document) async {
    log('Inserting document in DB');
    final db = await _databaseHelper.database;
    final newDocumentId = await db.insert(
      documentTable,
      document.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return newDocumentId;
  }

  Future<int> insertDocumentImage(DocumentImage documentImage) async {
    log('Inserting image in DB');
    final db = await _databaseHelper.database;

    final Directory baseDir = await getApplicationDocumentsDirectory();
    // TODO: generate random file name to prevent duplication conflicts.
    final path = baseDir.path;
    final fileName = basename(documentImage.path);
    final fileExtension = extension(documentImage.path); // e.g. '.jpg'
    final newPath = '$path/$fileName$fileExtension';
    File(documentImage.path).copy('$path/$fileName');

    documentImage.path = newPath;

    final newDocumentImageId = await db.insert(
      imageTable,
      documentImage.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return newDocumentImageId;
  }

  Future<List<BaseDocument>> getDocuments() async {
    log('Getting documents from DB');
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> documentMaps =
        await db.query(documentTable);

    return List.generate(documentMaps.length,
        (index) => BaseDocument.fromMap(documentMaps[index]));
  }

  Future<BaseDocument> getDocumentById(int documentId) async {
    log('Getting document by Id in DB');
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> documentMaps = await db.query(
      documentTable,
      where: 'id = ?',
      whereArgs: [documentId],
      limit: 1,
    );
    return BaseDocument.fromMap(documentMaps.first);
  }

  Future<List<DocumentImage>> getDocumentImages(int documentId) async {
    log('Getting document image from DB');
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> documentImageMaps = await db.query(
      imageTable,
      where: 'documentId = ?',
      whereArgs: [documentId],
    );
    log(documentImageMaps.toString());
    return List.generate(documentImageMaps.length,
        (index) => DocumentImage.fromMap(documentImageMaps[index]));
  }

  Future<DocumentImage> getDocumentImageById(int id) async {
    log('Getting document image by Id from DB');
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> documentImageMaps = await db.query(
      documentTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return DocumentImage.fromMap(documentImageMaps.first);
  }

  Future<int> updateDocument(int documentId, BaseDocument document) async {
    log('Updating document in DB');
    final db = await _databaseHelper.database;

    final updatedDocumentId = await db.update(
      documentTable,
      document.toMap(),
      where: 'id = ?',
      whereArgs: [documentId],
    );
    return updatedDocumentId;
  }

  Future<int> deleteDocument(int documentId) async {
    log('Deleting document in DB');

    final db = await _databaseHelper.database;

    final deletedDocumentId = await db.delete(
      documentTable,
      where: 'id = ?',
      whereArgs: [documentId],
    );
    return deletedDocumentId;
  }

  Future<int> deleteDocumentImage(int imageId) async {
    log('Deleting document image in DB');

    final db = await _databaseHelper.database;

    final documentImage = await getDocumentImageById(imageId);
    File(documentImage.path).delete();

    final deletedDocumentImageId = await db.delete(
      imageTable,
      where: 'id = ?',
      whereArgs: [imageId],
    );
    return deletedDocumentImageId;
  }

  // Future<int> xinsertDocumentWithImage(Document document) async {
  //   final db = await _databaseHelper.database;
  //   final newDocumentDBModel =
  //       Document(title: document.title, note: document.note);

  //   final newDocumentId = await db.insert(
  //     documentTable,
  //     newDocumentDBModel.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   Batch batch = db.batch();
  //   for (DocumentImage documentImage in document.images) {
  //     var newImageDBModel = DocumentImage(
  //       path: documentImage.path,
  //       documentId: newDocumentId,
  //     );
  //     newImageDBModel.documentId = newDocumentId;
  //     batch.insert(imageTable, newImageDBModel.toMap());
  //   }
  //   batch.commit(noResult: true);

  //   return newDocumentId;
  // }

  Future<List<Document>> getDocumentsWithImages() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> documentMaps =
        await db.query(documentTable);

    final List<Document> documents = [];

    for (Map<String, dynamic> documentMap in documentMaps) {
      final images = await getDocumentImages(documentMap['id']);
      final document = Document.fromMap({...documentMap, 'images': images});
      documents.add(document);
    }
    return documents;
  }

  Future<Document> getDocumentWithImagesById(int documentId) async {
    final db = await _databaseHelper.database;
    final baseDocument = await getDocumentById(documentId);

    final images = getDocumentImages(documentId);
    final document =
        Document.fromMap({...baseDocument.toMap(), 'images': images});
    return document;
  }

  Future<int> xinsertDocument(
    BaseDocument document,
  ) async {
    final db = await _databaseHelper.database;

    final newDocumentId = await db.insert(
      documentTable,
      document.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return newDocumentId;
  }
}
