import 'package:flutter/material.dart';
import 'package:parichaya_frontend/models/document_model.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';
import './document_tile.dart';
import '../screens/document_details.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final documentList = query.isEmpty
        ? []
        : Provider.of<Documents>(context)
            .items
            .where((document) =>
                document.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (query.isNotEmpty)
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
                  Navigator.of(context).pushReplacementNamed(
                      DocumentDetails.routeName,
                      arguments: document.id);
                },
              );
            },
          ).toList(),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final documentList = query.isEmpty
        ? []
        : Provider.of<Documents>(context)
            .items
            .where((document) =>
                document.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (documentList.isNotEmpty)
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
                  Navigator.of(context).pushReplacementNamed(
                      DocumentDetails.routeName,
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
