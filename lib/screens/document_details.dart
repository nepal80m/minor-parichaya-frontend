import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/display_items.dart';
import '../providers/documents.dart';
import '../utils/string.dart';

class DocumentDetails extends StatelessWidget {
  const DocumentDetails({Key? key}) : super(key: key);

  static const routeName = '/document_details';

  @override
  Widget build(BuildContext context) {
    final routeDocumentId =
        ModalRoute.of(context)?.settings.arguments as String;

    final document =
        Provider.of<Documents>(context).getDocumentById(routeDocumentId);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: Text(
          generateLimitedLengthText(document.title, 25),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
              child: DisplayItems(document.title, document.note,
                  document.images, constraints.maxHeight)),
        );
      }),
    );
  }
}
