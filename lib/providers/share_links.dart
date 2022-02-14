import 'package:flutter/cupertino.dart';
import 'package:parichaya_frontend/models/document_model.dart';

import '../models/share_link_model.dart';

class ShareLinks with ChangeNotifier {
  final List<ShareLink> _items = [];

  List<ShareLink> get sharedItems {
    return [..._items];
  }

  int addShareLinks(
    List<Document> selectedDocuments,
    String expiryDate,
    String title,
  ) {
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
