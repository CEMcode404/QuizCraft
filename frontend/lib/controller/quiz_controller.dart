import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/utils/error_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/model/quiz_model.dart';

class QuizController {
  Future<QuizModel?> generateQuiz(
      BuildContext context, String paragraph) async {
    if (paragraph.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'Paragraph cannot be empty',
          );
        },
      );
      return null;
    }

    final response = await http.post(
      Uri.parse('http://localhost:5000/generateQuiz'), //this is dynamic FIX
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'paragraph': paragraph,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return QuizModel.fromJson(data);
    } else {
      throw Exception('Failed to generate quiz');
    }
  }
}
