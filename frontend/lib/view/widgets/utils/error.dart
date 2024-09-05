import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Error',
            style: const TextStyle(
              fontFamily: 'Arial', // Set Arial font for the title
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Arial', // Set Arial font for the content text
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Arial', // Set Arial font for the button text
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
