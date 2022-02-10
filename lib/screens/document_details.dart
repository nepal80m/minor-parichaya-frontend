import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/documents.dart';
import '../utils/string.dart';
import './edit_document.dart';
import './full_screen_image.dart';

enum selectionValue {
  edit,
  delete,
}

Future<void> pickImage(
    BuildContext context, ImageSource source, int documentId) async {
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    Provider.of<Documents>(context, listen: false)
        .addDocumentImage(documentId, image.path);
  } on PlatformException catch (e) {
    return;
  }
}

class DocumentDetails extends StatelessWidget {
  const DocumentDetails({Key? key}) : super(key: key);

  static const routeName = '/document_details';

  @override
  Widget build(BuildContext context) {
    final routeDocumentId = ModalRoute.of(context)?.settings.arguments as int;

    final document =
        Provider.of<Documents>(context).getDocumentById(routeDocumentId);

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
                Navigator.of(context)
                    .pushNamed(EditDocument.routeName, arguments: document.id);
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
                Text(document.images.length.toString()),
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
                Column(
                  children: [
                    ...document.images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          child: Image.file(
                            File(image.path),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                FullScreenImage.routeName,
                                arguments: image);
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
                // for (var image in document.images)
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: [
                      const Text('Select Actions'),
                      ListTile(
                        leading: const Icon(Icons.file_upload_rounded),
                        title: const Text('Upload Image'),
                        onTap: () {
                          pickImage(context, ImageSource.gallery, document.id);
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera_alt_rounded),
                        title: const Text('Take a Photo'),
                        onTap: () {
                          pickImage(context, ImageSource.camera, document.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Add Image',
        elevation: 2,
        child: const Icon(Icons.insert_photo_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
