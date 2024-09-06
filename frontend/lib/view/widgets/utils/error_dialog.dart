import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Error',
          style: const TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontFamily: 'Arial',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              fontFamily: 'Arial',
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
