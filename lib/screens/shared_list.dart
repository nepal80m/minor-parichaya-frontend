import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/share_links.dart';
import '../widgets/shared_document_tile.dart';

class SharedList extends StatelessWidget {
  const SharedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedDocumentsList = Provider.of<ShareLinks>(context).sharedItems;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                '${sharedDocumentsList.length} DOCUMENTS',
              )),
          const SizedBox(
            height: 10,
          ),
          ...sharedDocumentsList.map((element) {
            return SharedDocumentTile(
                title: element.title, expiryDate: element.expiryDate);
          }).toList(),
        ],
      ),
    );
  }
}
