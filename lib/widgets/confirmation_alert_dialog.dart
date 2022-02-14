import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(BuildContext context,
    {required String message, String alertTitle = "Are you sure?"}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertTitle),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text("Continue"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (result == null) {
    return false;
  }
  return result;
}
