import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/share_links.dart';
import '../widgets/shared_document_tile.dart';

// import '../widgets/custom_icons_icons.dart';

class ShareDetails extends StatefulWidget {
  const ShareDetails({Key? key}) : super(key: key);

  static const routeName = '/share_details';

  @override
  State<ShareDetails> createState() => _ShareDetailsState();
}

class _ShareDetailsState extends State<ShareDetails> {
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String;
    final sharedDocumentList =
        Provider.of<ShareLinks>(context).sharedItems.reversed;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Provider.of<ShareLinks>(context, listen: false).clearDocument();
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
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
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
                        Icons.qr_code,
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
            ...sharedDocumentList.map(
              (document) {
                return SharedDocumentTile(
                  title: document.title,
                  expiryDate: document.expiryDate,
                );
              },
            ).toList()
          ],
        ),
      ),
    );
  }
}
