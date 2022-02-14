import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../models/db_models/document_image_model.dart';
// import './document_details.dart';
// import '../providers/documents.dart';
// import '../models/db_models/document_image_model.dart';

class FullScreenGallery extends StatelessWidget {
  final List<DocumentImage> documentImages;
  final initialIndex;
  final List<Widget>? appBarActions;

  const FullScreenGallery({
    required this.documentImages,
    required this.initialIndex,
    this.appBarActions,
    Key? key,
  }) : super(key: key);

  // static const routeName = '/fullscreen_image';

  @override
  Widget build(BuildContext context) {
    // final imageDoc =
    // ModalRoute.of(context)?.settings.arguments as DocumentImage;
    // final document =
    //     Provider.of<Documents>(context).getDocumentById(imageDoc.documentId);

    // AlertDialog alert = AlertDialog(
    //   title: const Text("Confirmation"),
    //   content: const Text("Are you sure you want to delete this image?"),
    //   actions: [
    //     TextButton(
    //       child: const Text("Cancel"),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //     TextButton(
    //       child: const Text("Continue"),
    //       onPressed: () {
    //         if (document.images.length > 1) {
    //           Provider.of<Documents>(context, listen: false)
    //               .deleteDocumentImage(imageDoc);
    //           const snackBar = SnackBar(
    //             content: Text('Image Successfully Deleted'),
    //           );
    //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //         } else {
    //           final snackBar = SnackBar(
    //               backgroundColor: Theme.of(context).errorColor,
    //               content: const Text(
    //                   'You must have atleast one image in the document.'));
    //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //         }
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ],
    // );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          actions: appBarActions),
      body: PhotoViewGallery.builder(
        pageController: PageController(initialPage: initialIndex),
        // enableRotation: true,
        allowImplicitScrolling: true,
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(
              File(
                documentImages[index].path,
              ),
            ),
            filterQuality: FilterQuality.high,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 5,
          );
        },
        itemCount: documentImages.length,
      ),
    );
  }
}