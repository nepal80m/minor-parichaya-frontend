import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parichaya_frontend/models/document.dart';
import 'package:parichaya_frontend/share_to_inbox_buttom_sheet.dart';
import 'package:parichaya_frontend/widgets/custom_icons_icons.dart';
import 'package:parichaya_frontend/widgets/ui/custom_elevated_button.dart';
// import '../widgets/custom_icons_icons.dart';
import '../datas/dummy_documents.dart';

import '../widgets/document_tile.dart';

class ShareDetails extends StatefulWidget {
  const ShareDetails({Key? key}) : super(key: key);

  @override
  State<ShareDetails> createState() => _ShareDetailsState();
}

class _ShareDetailsState extends State<ShareDetails> {
  final title = 'Shared to Lalitpur Engineering College for Admission';
  final sharedDocumentList = DUMMY_DOCS;

  void addNewTransaction(String title, double amount, DateTime chosenDate) {}

  void startAddTransaction(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return ShareToInboxBottomSheet(addNewTransaction);
      },
    );
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   context: context,
    //   builder: (_) {
    //     return GestureDetector(
    //       onTap: () {},
    //       behavior: HitTestBehavior.opaque,
    //       child: ShareToInbox(addNewTransaction),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        // leading: const Icon(Icons.arrow_back_ios_new_rounded),
        // leading: Icon(CustomIcons.link_filled),
        title: const Text('DETAILS'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Share'),
                value: 'share',
              ),
              PopupMenuItem(
                child: Text('Expire this link'),
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
                style: TextStyle(fontSize: 20),
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
                      CustomElevatedButton(
                          child: const Text('SEND TO PERSONAL INBOX'),
                          onPressed: () {
                            startAddTransaction(context);
                          })
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
                return DocumentTile(
                  title: document.title,
                  image: document.images[0],
                );
              },
            ).toList()
          ],
        ),
      ),
    );
  }
}
