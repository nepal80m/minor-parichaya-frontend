import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:parichaya_frontend/models/db_models/document_image_model.dart';
import 'package:provider/provider.dart';

import './document_details.dart';
import '../providers/documents.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key}) : super(key: key);

  static const routeName = '/fullscreen_image';

  @override
  Widget build(BuildContext context) {
    final imageDoc =
        ModalRoute.of(context)?.settings.arguments as DocumentImage;
    final document =
        Provider.of<Documents>(context).getDocumentById(imageDoc.documentId);

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        if (document.images.length > 1) {
          Provider.of<Documents>(context, listen: false)
              .deleteDocumentImage(imageDoc);
          const snackBar =
              SnackBar(content: Text('Image Successfully Deleted'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
              backgroundColor: Theme.of(context).errorColor,
              content: const Text(
                  'You must have atleast one image in the document.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        Navigator.popUntil(
            context, ModalRoute.withName(DocumentDetails.routeName));
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ),
          ]),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.file(
          File(imageDoc.path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
