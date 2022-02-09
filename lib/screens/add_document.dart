import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parichaya_frontend/screens/document_details.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';
import '../widgets/ui/custom_text_field.dart';

class AddDocuments extends StatefulWidget {
  const AddDocuments({Key? key}) : super(key: key);
  static const routeName = '/add_documents';

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  // final List<Image> uploadedImages = [];
  final titleController = TextEditingController();
  var titleErrorMessage = '';
  final noteController = TextEditingController();
  var noteErrorMessage = '';
  final List<String> uploadedImagePaths = [];
  var imageErrorMessage = '';

  void addDocument(context) async {
    titleErrorMessage = '';
    imageErrorMessage = '';
    setState(() {
      titleErrorMessage =
          titleController.text.isEmpty ? 'Title is required.' : '';
      imageErrorMessage = uploadedImagePaths.isEmpty
          ? 'You must upload atleast one image.'
          : '';
    });

    if (titleController.text.isNotEmpty && uploadedImagePaths.isNotEmpty) {
      final newDocumentId = await Provider.of<Documents>(context, listen: false)
          .addDocument(
              titleController.text, noteController.text, uploadedImagePaths);
      Navigator.of(context)
          .popAndPushNamed(DocumentDetails.routeName, arguments: newDocumentId);
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        uploadedImagePaths.add(image.path);
        imageErrorMessage = '';
      });
    } on PlatformException catch (e) {
      return;
    }
  }

  void unPickImage(int index) {
    setState(() {
      uploadedImagePaths.removeAt(index);
    });
  }

  void showAddImageModalBottomSheet(BuildContext context) {
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
                Text('Select Actions'),
                ListTile(
                  leading: Icon(Icons.file_upload_rounded),
                  title: Text('Upload Image'),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text('Take a Photo'),
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.clear),
        ),
        titleSpacing: 5,
        title: const Text(
          'ADD NEW DOCUMENT',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    // side: BorderSide(color: Colors.red),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).canvasColor),
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(0.1)),
              ),
              label: Text('Done'),
              icon: Icon(Icons.done),
              onPressed: () {
                addDocument(context);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddImageModalBottomSheet(context);
        },
        child: Icon(Icons.add_photo_alternate_rounded),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'TITLE',
                      controller: titleController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      errorMessage: titleErrorMessage,
                      onChanged: (value) {
                        if (titleErrorMessage.isNotEmpty && value.isNotEmpty) {
                          setState(() {
                            titleErrorMessage = '';
                          });
                        }
                      },
                    ),
                    CustomTextField(
                      label: 'NOTE',
                      controller: noteController,
                      maxLines: 3,
                      errorMessage: noteErrorMessage,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFieldLabel('IMAGES',
                        errorMessage: imageErrorMessage),
                  ],
                ),
              ),
              GridView.count(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: [
                    ...List.generate(
                      uploadedImagePaths.length,
                      (index) {
                        return Center(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(uploadedImagePaths[index]),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    unPickImage(index);
                                  },
                                  icon: Icon(Icons.cancel),
                                  // size: 40,
                                  // color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showAddImageModalBottomSheet(context);
                          // pickImage(ImageSource.gallery);
                        },
                        splashColor: Theme.of(context).primaryColor,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }),
    );
  }
}
