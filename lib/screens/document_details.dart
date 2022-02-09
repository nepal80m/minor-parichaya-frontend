import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';
import '../utils/string.dart';
import './edit_document.dart';

enum selectionValue {
  edit,
  delete,
}

class DocumentDetails extends StatelessWidget {
  const DocumentDetails({Key? key}) : super(key: key);

  static const routeName = '/document_details';

  @override
  Widget build(BuildContext context) {
    final routeDocumentId = ModalRoute.of(context)?.settings.arguments as int;

    final document = Provider.of<Documents>(context, listen: false)
        .getDocumentById(routeDocumentId);

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        return;
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Provider.of<Documents>(context, listen: false)
            .deleteDocument(document.id);
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Down to Delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        title: Text(
          generateLimitedLengthText(document.title, 25),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == selectionValue.edit) {
                Navigator.of(context).pushNamed(EditDocument.routeName);
              } else if (value == selectionValue.delete) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                value: selectionValue.edit,
              ),
              PopupMenuItem(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                value: selectionValue.delete,
              ),
            ],
          )
        ],
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  document.note,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                // for (var image in document.images)
                ...document.images.map((image) {
                  return Image.file(
                    File(image.path),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
