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

    for (BaseShareLink baseShareLink in baseShareLinks) {
      // TODO: fetch documents from server and add to document list.
      final shareLink = ShareLink.fromMap({
        ...baseShareLink.toMap(),
      });
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

  Future<ShareLink> addShareLink({
    required String title,
    required String expiryDate,
    required List<Document> documents,
  }) async {
    // TODO: make POST request to server to create new share link and get sharelink object from server

    // TODO: replace this serverID with the one from POST response
    const serverId = 'my_server_id';
    // TODO: replace this serverID with the one from POST response
    const encryptionKey = 'my_very_secret_key';

    final newBaseShareLink = await _databaseHelper.insertShareLink(
      BaseShareLink(
        serverId: serverId,
        title: title,
        createdOn: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        encryptionKey: encryptionKey,
        expiryDate: expiryDate,
      ),
    );

    final newShareLink = ShareLink.fromBaseShareLink(
      id: newBaseShareLink.id!,
      baseShareLink: newBaseShareLink,
      documents: documents,
    );

    // option 1
    _items.add(newShareLink);
    notifyListeners();
    // option 2
    // syncToDB();

    return newShareLink;
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
    // TODO: Make http POST to add document to share link with serverId and eencryptionKey.

    // TODO: Create new documnet object based on the reseponse and add to existingSharedLink
    existingShareLink.documents.add(document);
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
