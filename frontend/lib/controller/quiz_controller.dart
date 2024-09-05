import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/model/quiz_model.dart';

class QuizController {
  Future<QuizModel?> generateQuiz(String paragraph) async {
    final response = await http.post(
      Uri.parse(
          'https://a1ce-115-85-43-90.ngrok-free.app/generateQuiz'), //this is dynamic FIX
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
