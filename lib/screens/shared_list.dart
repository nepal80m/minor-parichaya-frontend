import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/share_links.dart';
import '../widgets/shared_document_tile.dart';
import 'share_details.dart';

class SharedList extends StatelessWidget {
  const SharedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shareLinks = Provider.of<ShareLinks>(context).items;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                '${shareLinks.length} SHARABLE LINKS',
              )),
          const SizedBox(
            height: 10,
          ),
          ...shareLinks.map((shareLink) {
            return SharedDocumentTile(
              title: shareLink.title.toUpperCase(),
              expiryDate: shareLink.expiryDate,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ShareDetails.routeName, arguments: shareLink.id);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
