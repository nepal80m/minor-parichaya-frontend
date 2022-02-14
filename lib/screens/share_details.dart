import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parichaya_frontend/widgets/shared_document_details_tile.dart';
import 'package:provider/provider.dart';

import '../providers/share_links.dart';
import '../widgets/shared_document_details_tile.dart';

// import '../widgets/custom_icons_icons.dart';

class ShareDetails extends StatelessWidget {
  const ShareDetails({Key? key}) : super(key: key);

  static const routeName = '/share_details';

  @override
  Widget build(BuildContext context) {
    final sharedLinkId = ModalRoute.of(context)?.settings.arguments as int;
    final shareLink = Provider.of<ShareLinks>(context, listen: false)
        .getShareLinkById(sharedLinkId);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('DETAILS'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Share'),
                value: 'share',
              ),
              PopupMenuItem(
                child: const Text('Expire this link'),
                textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.red,
                      // fontWeight: FontWeight.bold,
                    ),
                value: 'delete',
              ),
            ],
            onSelected: (String newValue) {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                shareLink.title.toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Expiry Date : ${shareLink.expiryDate}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 2,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.qr_code_2,
                        size: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('parichaya.com/ag32v3r...'),
                          Flexible(
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 20,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.copy,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: const Text('SHARED DOCUMENTS'),
            ),
            const SizedBox(
              height: 10,
            ),
            ...shareLink.documents.map(
              (document) {
                return SharedDocumentDetailsTile(
                  title: document.title,
                  images: document.images,
                  onTap: () {},
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
