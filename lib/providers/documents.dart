import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parichaya_frontend/database/database_helper.dart';
import 'package:parichaya_frontend/models/db_models/document_image_model.dart';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:sqflite/sqflite.dart';
import '../models/db_models/base_document_model.dart';

class Documents with ChangeNotifier {
  final List<Document> _items = [];
  // final List<Document> _items = [
  //   Document(
  //     id: 1,
  //     title: 'Citizenship',
  //     // tags: ['Government'],
  //     note: 'This is my Fake Nagarikta',
  //   ),
  //   Document(
  //     id: 2,
  //     title: 'Licence',
  //     // tags: ['Government', 'Bike'],
  //     note: 'This is my Fake Licence',
  //   ),
  //   Document(
  //     id: 3,
  //     title: 'School Leaving Certificate',
  //     // tags: ['Education', 'School'],
  //     note: 'This is my Fake School leaving certificate',
  //   ),
  //   Document(
  //     id: 4,
  //     title: 'Passport',
  //     // tags: ['Government'],
  //     note: 'This is my Fake Passport',
  //   ),
  //   Document(
  //     id: 5,
  //     title: 'Khop Card',
  //     // tags: ['Government', 'Covid'],
  //     note: 'This is my Fake Khop Card',
  //   ),
  // ];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Documents() {
    DatabaseHelper _tempdataBaseHelper = DatabaseHelper();
    _databaseHelper = _tempdataBaseHelper;
    syncToDB();
  }

  void syncToDB() async {
    final List<BaseDocument> baseDocuments =
        await _databaseHelper.getDocuments();

    final List<Document> documents = [];

    for (BaseDocument baseDocument in baseDocuments) {
      final images = await _databaseHelper.getDocumentImages(baseDocument.id!);
      final document =
          Document.fromMap({...baseDocument.toMap(), 'images': images});
      documents.add(document);
    }
    _items.clear();
    _items.addAll([...documents]);
    notifyListeners();
  }

  void syncToDBBackend() async {
    final documents = await _databaseHelper.getDocumentsWithImages();
    _items.addAll([...documents]);
    notifyListeners();
  }

  List<Document> get items {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  bool checkIfDocumentExists(int documentId) {
    return _items.any((document) => document.id == documentId);
  }

  Document getDocumentById(int documentId) {
    return _items.firstWhere((document) => document.id == documentId);
  }

  Future<Document> addDocument(
    String title,
    String note,
    List<String> imagePaths,
  ) async {
    final newBaseDocument = await _databaseHelper
        .insertDocument(BaseDocument(title: title, note: note));

    final newDocument =
        Document(id: newBaseDocument.id!, title: title, note: note, images: []);

    for (String imagePath in imagePaths) {
      final newDocumentImage = await _databaseHelper.insertDocumentImage(
        DocumentImage(
          path: imagePath,
          documentId: newBaseDocument.id!,
        ),
      );
      newDocument.images.add(newDocumentImage);
    }
    // option 1
    _items.add(newDocument);
    notifyListeners();
    // option 2
    // syncToDB();

    return newDocument;
  }

  Future<int> updateDocument(
    int documentId,
    String? title,
    String? note,
  ) async {
    var existingDocument = getDocumentById(documentId);
    if (title != null) {
      existingDocument.title = title;
    }
    if (note != null) {
      existingDocument.note = note;
    }
    await _databaseHelper.updateDocument(
      documentId,
      existingDocument.toBaseDocument(),
    );
    notifyListeners();
    return documentId;
  }

  Future<DocumentImage> addDocumentImage(
    int documentId,
    String imagePath,
  ) async {
    final newDocumentImage = await _databaseHelper.insertDocumentImage(
        DocumentImage(path: imagePath, documentId: documentId));

    final existingDocument = getDocumentById(documentId);
    existingDocument.images.add(newDocumentImage);
    notifyListeners();
    return newDocumentImage;
  }

  void deleteDocumentImage(DocumentImage documentImage) {
    /// Deletes the image with id=imageId and returns documentId.
    final existingDocument = getDocumentById(documentImage.documentId);
    existingDocument.images
        .removeWhere((image) => image.id == documentImage.id);
    _databaseHelper.deleteDocumentImageById(documentImage.id!);

    notifyListeners();
    // return documentImage.documentId;
  }

  Future<void> deleteDocument(int documentId, {bool notify = true}) async {
    // TODO: try making this function synchronous
    _items.removeWhere((document) => document.id == documentId);
    await _databaseHelper.deleteDocument(documentId);
    if (notify) {
      notifyListeners();
    }
  }
}

const nagariktaImgURL =
    'https://scontent.fktm1-2.fna.fbcdn.net/v/t1.6435-9/86265665_514718655838386_6235550399277826048_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=O3Pqxxh0XV0AX9bgjhc&_nc_ht=scontent.fktm1-2.fna&oh=00_AT_DunItJCWLI0DMQgeQjyXGfI4T7p1qywBK1HfR6MSa-Q&oe=6220B9DB';
const licenceImgURL =
    'https://thehimalayantimes.com/uploads/imported_images/wp-content/uploads/2018/04/Smart-driving-licence-specimen.jpg';
const slcImgURL =
    'https://leverageedu.com/blog/wp-content/uploads/2021/05/SLC2-01-1024x791.jpg';

const passportImgURL =
    'https://ultrareproduction.com/wp-content/uploads/2021/04/uk-passport.jpg';

const khopCardImgURL =
    'https://vaccine.mohp.gov.np/images/khop_card.jpg?ff2c4af8149164d4907942fdb3d48ca2';
