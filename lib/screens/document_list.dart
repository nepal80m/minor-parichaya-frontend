import 'package:flutter/material.dart';

import '../widgets/document_tile.dart';
import '../dataset/dummy_documents.dart';

import 'view_document_screen.dart';

class DocumentList extends StatelessWidget {
  final documentList = DUMMY_DOCS;
  DocumentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                '${documentList.length} DOCUMENTS',
              )),
          const SizedBox(
            height: 10,
          ),
          ...documentList.map(
            (document) {
              return DocumentTile(
                title: document.title,
                image: document.images[0],
                onTap: () {
                  // TODO: Open document details page.
                  Navigator.of(context).pushNamed(ViewDocuments.routeName,
                      arguments: document.id);
                },
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
