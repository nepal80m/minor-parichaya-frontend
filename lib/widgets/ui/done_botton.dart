import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DoneButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        onPressed: onPressed,
      ),
    );
  }
}
