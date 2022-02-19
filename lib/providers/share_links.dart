import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parichaya_frontend/database/database_helper.dart';
import 'package:parichaya_frontend/models/db_models/base_share_link_model.dart';
import 'package:parichaya_frontend/models/db_models/document_image_model.dart';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:parichaya_frontend/models/share_link_model.dart';
import 'package:sqflite/sqflite.dart';
import '../models/db_models/base_document_model.dart';

class ShareLinks with ChangeNotifier {
  final List<ShareLink> _items = [];

  DatabaseHelper _databaseHelper = DatabaseHelper();

  ShareLinks() {
    DatabaseHelper _tempdataBaseHelper = DatabaseHelper();
    _databaseHelper = _tempdataBaseHelper;
    syncToDB();
  }

  void syncToDB() async {
    final List<BaseShareLink> baseShareLinks =
        await _databaseHelper.getShareLinks();

    final List<ShareLink> shareLinks = [];
    const baseUrl = 'http://192.168.100.171:8000/api/share-link/';

    for (BaseShareLink baseShareLink in baseShareLinks) {
      final serverId = baseShareLink.serverId;
      final encryptionKey = baseShareLink.encryptionKey;
      final url = baseUrl + '$serverId/$encryptionKey';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = json.decode(response.body);
      final createdOn = responseData['created_on'];
      final expiryDate = responseData['expiry_date'];
      final documentMaps = responseData['documents'];
      final shareLink = ShareLink(
          id: baseShareLink.id!,
          serverId: baseShareLink.serverId,
          title: baseShareLink.title,
          encryptionKey: baseShareLink.encryptionKey,
          createdOn: DateTime.parse(createdOn),
          expiryDate: DateTime.parse(expiryDate),
          documents: []);
      for (Map documentMap in documentMaps) {
        final document = Document(
          id: documentMap['id'],
          title: documentMap['title'],
          note: '',
          images: [],
        );
        for (Map imageMap in documentMap['images']) {
          document.images.add(
            DocumentImage(
                path: baseUrl + 'image/${imageMap['id']}/$encryptionKey/',
                documentId: document.id),
          );
        }
        shareLink.documents.add(document);
      }

      shareLinks.add(shareLink);
    }
    _items.clear();
    _items.addAll([...shareLinks]);
    notifyListeners();
  }

  List<ShareLink> get items {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  bool checkIfShareLinkExists(int shareLinkId) {
    return _items.any((shareLink) => shareLink.id == shareLinkId);
  }

  ShareLink getShareLinkById(int shareLinkId) {
    return _items.firstWhere((shareLink) => shareLink.id == shareLinkId);
  }

  Future<int> addShareLink({
    required String title,
    required String expiryDate,
    required List<Document> documents,
  }) async {
    const url = 'http://192.168.100.171:8000/api/share-link/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'title': title,
          'expiryDate': expiryDate,
        },
      ),
    );
    final responseData = json.decode(response.body);

    final _serverId = responseData['id'];
    final _encryptionKey = responseData['encryption_key'];
    final _createdOn = responseData['created_on'];
    final _expiryDate = responseData['expiry_date'];

    final newBaseShareLink = await _databaseHelper.insertShareLink(
      BaseShareLink(
        serverId: _serverId,
        title: title,
        encryptionKey: _encryptionKey,
      ),
    );
    // create new ShareLink for state
    final newShareLink = ShareLink(
      id: newBaseShareLink.id!,
      serverId: _serverId,
      title: title,
      encryptionKey: _encryptionKey,
      createdOn: DateTime.parse(_createdOn),
      expiryDate: DateTime.parse(_expiryDate),
      documents: [],
    );
    // option 1
    _items.add(newShareLink);
    notifyListeners();
    // option 2
    // syncToDB();

    return newShareLink.id;
  }

  Future<int> updateShareLink(
    int shareLinkId,
    String? title,
  ) async {
    var existingShareLink = getShareLinkById(shareLinkId);
    if (title != null) {
      existingShareLink.title = title;
    }

    await _databaseHelper.updateShareLink(
      shareLinkId,
      existingShareLink.toBaseShareLink(),
    );
    notifyListeners();
    return shareLinkId;
  }

  Future<Document> addSharedDocument(
    int shareLinkId,
    Document document,
  ) async {
    final existingShareLink = getShareLinkById(shareLinkId);
    final url =
        'http://192.168.100.171:8000/api/share-link/${existingShareLink.serverId}/${existingShareLink.encryptionKey}/add-document/';
    // TODO: Make http POST to add document to share link with serverId and eencryptionKey.
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'document': document}),
    );

    log(json.decode(response.body).toString());
    existingShareLink.documents.add(document);
    // TODO: Create new documnet object based on the response and add to existingSharedLink
    // existingShareLink.documents.add(document);
    notifyListeners();
    return document;
  }

  void deleteSharedDocument(int shareLinkId, int sharedDocumentId) {
    log('deleting shared document');
    final existingShareLink = getShareLinkById(shareLinkId);
    // TODO: Make http DELETE to delete document in share link with id
    existingShareLink.documents
        .removeWhere((document) => document.id == sharedDocumentId);

    notifyListeners();
    // return documentImage.documentId;
  }

  void deleteShareLink(int shareLinkId) {
    // TODO:make HTTP DELETE request to delete the share link.
    _items.removeWhere((shareLink) => shareLink.id == shareLinkId);
    notifyListeners();
  }
}
