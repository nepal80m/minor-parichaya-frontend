import 'package:flutter/cupertino.dart';

import '../models/share_link_model.dart';

class ShareLinks with ChangeNotifier {
  final List<ShareLink> _items = [];

  List<ShareLink> get sharedItems {
    return [..._items];
  }

  void addShareLinks(
    List selectedDocuments,
    String expiryDate,
  ) {
    for (var i in selectedDocuments) {
      _items.add(
        ShareLink(
            title: i.title,
            serverId: 'serverId',
            createdOn: DateTime.now(),
            expiryDate: expiryDate,
            encryptionkey: 'encryptionkey'),
      );
    }
  }

  void clearDocument() {
    _items.clear();
  }
}
