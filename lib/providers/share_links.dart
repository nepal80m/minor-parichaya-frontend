import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:http/http.dart' as http;

import '../models/share_link_model.dart';

class ShareLinks with ChangeNotifier {
  final List<ShareLink> _items = [];

  List<ShareLink> get sharedItems {
    return [..._items];
  }

  Future<int> addShareLinks(
    List<Document> selectedDocuments,
    String expiryDate,
    String title,
  ) async {
    const url = 'http://192.168.100.171:8000/api/share-link/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': title,
            'expiryDate': expiryDate,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );
      var uuid = json.decode(response.body);
      if (response.statusCode >= 200) {
        log(uuid.toString());
      }
    } catch (error) {
      log(error.toString());
    }

    final newId = DateTime.now().microsecondsSinceEpoch;
    _items.add(
      ShareLink(
          id: newId,
          title: title,
          serverId: 'serverId',
          createdOn: DateTime.now(),
          expiryDate: expiryDate,
          documents: selectedDocuments,
          encryptionkey: 'encryptionkey'),
    );

    notifyListeners();
    return newId;
  }

  ShareLink getShareLinkById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
