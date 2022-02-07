import 'package:flutter/material.dart';

class Document with ChangeNotifier {
  final String id;
  String title;
  // final List<String> tags;
  String note;
  final List<Image> images;

  Document({
    required this.id,
    required this.title,
    // required this.tags,
    required this.note,
    required this.images,
  });

  void updateDocument(
    String? title,
    String? note,
    List<Image>? images,
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
