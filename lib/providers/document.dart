import 'package:flutter/material.dart';

class Document with ChangeNotifier {
  final String id;
  String title;
  // final List<String> tags;
  String note;
  final List<String> images;

  Document({
    required this.id,
    required this.title,
    // required this.tags,
    this.note = '',
    required this.images,
  });

  void updateDocument(
    String? title,
    String? note,
    List<String>? images,
  ) {
    if (title != null) {
      this.title = title;
    }
    if (note != null) {
      this.note = note;
    }
    if (images != null) {
      this.images.clear();
      this.images.addAll(images);
    }
    notifyListeners();
  }
}
