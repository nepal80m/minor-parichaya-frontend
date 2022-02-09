import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/documents.dart';
import '../widgets/ui/custom_text_field.dart';
import './document_details.dart';

class EditDocument extends StatefulWidget {
  const EditDocument({Key? key}) : super(key: key);

  static const routeName = '/edit_document';

  @override
  _EditDocumentState createState() => _EditDocumentState();
}

class _EditDocumentState extends State<EditDocument> {
  var imageErrorMessage = '';
  var titleErrorMessage = '';

  void editDocument(context, documentid, titleController, noteController,
      uploadedImagePaths) {
    setState(() {
      titleErrorMessage =
          titleController.text.isEmpty ? 'Title is required.' : '';
      imageErrorMessage = uploadedImagePaths.isEmpty
          ? 'You must upload atleast one image.'
          : '';
    });
    if (titleController.text.isNotEmpty && uploadedImagePaths.isNotEmpty) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      Navigator.of(context)
          .pushNamed(DocumentDetails.routeName, arguments: documentid);
      Provider.of<Documents>(context, listen: false).updateDocument(
          documentid, titleController.text, noteController.text);
      // listen = true shows image but cant edit whereas listen = false doesnt show image but can edit
    }
  }

  void pickImage(ImageSource source, List uploadedImagePaths) async {
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

  void unPickImage(int index, List uploadedImagePaths) {
    setState(() {
      uploadedImagePaths.removeAt(index);
    });
  }

  void showAddImageModalBottomSheet(
      BuildContext context, List uploadedImagePaths) {
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
                    pickImage(ImageSource.gallery, uploadedImagePaths);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    pickImage(ImageSource.camera, uploadedImagePaths);
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
    final docId = ModalRoute.of(context)?.settings.arguments as int;
    final document =
        Provider.of<Documents>(context, listen: false).getDocumentById(docId);
    final titleController = TextEditingController(text: document.title);
    final noteController = TextEditingController(text: document.note);
    var noteErrorMessage = '';
    final List<String> uploadedImagePaths = List.generate(
        document.images.length, (index) => document.images[index].path);

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
          'EDIT DOCUMENT',
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
              label: const Text('Done'),
              icon: const Icon(Icons.done),
              onPressed: () {
                editDocument(context, document.id, titleController,
                    noteController, uploadedImagePaths);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddImageModalBottomSheet(context, uploadedImagePaths);
        },
        child: const Icon(Icons.add_photo_alternate_rounded),
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
                                padding: const EdgeInsets.all(8.0),
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
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    unPickImage(index, uploadedImagePaths);
                                  },
                                  icon: const Icon(Icons.cancel),
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
                          showAddImageModalBottomSheet(
                              context, uploadedImagePaths);
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
