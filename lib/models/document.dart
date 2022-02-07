import 'package:flutter/material.dart';

class Document {
  final String id;
  final String title;
  final List<String> tags;
  final String note;
  final List<Image> images;

  Document({
    required this.id,
    required this.title,
    required this.tags,
    required this.note,
    required this.images,
  });
}
