import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dataset/dummy_documents.dart';
import '../widgets/display_items.dart';
import '../widgets/document_tile.dart';

class ViewDocuments extends StatelessWidget {
  const ViewDocuments({Key? key}) : super(key: key);

  static const routeName = '/view_document';

  @override
  Widget build(BuildContext context) {
    final routeDocumentId =
        ModalRoute.of(context)?.settings.arguments as String;

    final doc =
        DUMMY_DOCS.firstWhere((element) => element.id == routeDocumentId);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: const Text(
          'VIEW DOCUMENT',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
              child: DisplayItems(
                  doc.title, doc.note, doc.images, constraints.maxHeight)),
        );
      }),
    );
  }
}
