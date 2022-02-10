import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:parichaya_frontend/models/db_models/document_image_model.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';
import '../utils/string.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key}) : super(key: key);

  static const routeName = '/fullscreen_image';

  @override
  Widget build(BuildContext context) {
    final imageDoc =
        ModalRoute.of(context)?.settings.arguments as DocumentImage;

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Provider.of<Documents>(context, listen: false)
            .deleteDocumentImage(imageDoc);
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
            generateLimitedLengthText(imageDoc.path, 25),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
