import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/documents.dart';
import '../widgets/document_tile.dart';

import 'document_details.dart';

class DocumentList extends StatelessWidget {
  // late List<Document> documentList;
  const DocumentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documentList = Provider.of<Documents>(context).items;
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
                imagePath: document.images[0].path,
                onTap: () {
                  Navigator.of(context).pushNamed(DocumentDetails.routeName,
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
