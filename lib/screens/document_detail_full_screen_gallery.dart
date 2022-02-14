import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:parichaya_frontend/widgets/full_screen_image.dart';
import 'package:provider/provider.dart';

import '../models/db_models/document_image_model.dart';
import '../models/document_model.dart';
import '../providers/documents.dart';
import '../widgets/confirmation_alert_dialog.dart';

class DocumentDetailFullScreenGallery extends StatelessWidget {
  const DocumentDetailFullScreenGallery({Key? key}) : super(key: key);

  static const routeName = '/document_detail_fullscreen_gallery';

  void deleteDocumentImage(
      BuildContext context, Document document, DocumentImage documentImage) {
    if (document.images.length > 1) {
      Provider.of<Documents>(context, listen: false)
          .deleteDocumentImage(documentImage);
      const snackBar = SnackBar(
        content: Text('Image Successfully Deleted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content:
              const Text('You must have atleast one image in the document.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentImage =
        ModalRoute.of(context)?.settings.arguments as DocumentImage;
    final document = Provider.of<Documents>(context)
        .getDocumentById(documentImage.documentId);
    return FullScreenGallery(
      documentImages: document.images,
      initialIndex: document.images.indexOf(documentImage),
      appBarActions: [
        Container(
          margin: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () async {
              final isConfirmed = await showDeleteConfirmationDialog(context,
                  message: "Deleting the image cannot be undone.");
              if (isConfirmed) {
                deleteDocumentImage(context, document, documentImage);
              }
            },
            icon: const Icon(
              Icons.delete,
              // color: Colors.redAccent,
              size: 30,
            ),
          ),
          // child: GestureDetector(
          //   onTap: () async {
          //     final isConfirmed = await showDeleteConfirmationDialog(context);
          //     if (isConfirmed) {
          //       deleteDocumentImage(context, document, documentImage);
          //     }
          //   },
          //   child: const Icon(
          //     Icons.clear,
          //     color: Colors.redAccent,
          //     size: 30,
          //   ),
          // ),
        ),
      ],
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //       elevation: 0,
    //       backgroundColor: Colors.transparent,
    //       systemOverlayStyle: const SystemUiOverlayStyle(
    //         statusBarColor: Colors.transparent,
    //       ),
    //       actions: [
    //         Container(
    //           margin: const EdgeInsets.all(10),
    //           child: GestureDetector(
    //             onTap: () async {
    //               final isConfirmed =
    //                   await showDeleteConfirmationDialog(context);
    //               if (isConfirmed) {
    //                 deleteDocumentImage(context, document, documentImage);
    //               }
    //             },
    //             child: const Icon(
    //               Icons.clear,
    //               color: Colors.redAccent,
    //               size: 30,
    //             ),
    //           ),
    //         ),
    //       ]),
    //   body: PhotoViewGallery.builder(
    //     pageController:
    //         PageController(initialPage: document.images.indexOf(documentImage)),
    //     // enableRotation: true,
    //     allowImplicitScrolling: true,
    //     scrollPhysics: const BouncingScrollPhysics(),
    //     builder: (BuildContext context, int index) {
    //       return PhotoViewGalleryPageOptions(
    //         imageProvider: FileImage(
    //           File(
    //             document.images[index].path,
    //           ),
    //         ),
    //         filterQuality: FilterQuality.high,
    //         minScale: PhotoViewComputedScale.contained,
    //         maxScale: PhotoViewComputedScale.contained * 5,
    //       );
    //     },
    //     itemCount: document.images.length,
    //   ),
    // );
  }
}
