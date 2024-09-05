import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/model/quiz_model.dart';

class QuizController {
  Future<QuizModel?> generateQuiz(String paragraph) async {
    print('test');
    final response = await http.post(
      Uri.parse('https://62d1-115-85-43-90.ngrok-free.app/generateQuiz'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'paragraph': paragraph,
      }),
    );
    print('test2');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return QuizModel.fromJson(data);
    } else {
      throw Exception('Failed to generate quiz');
    }
  }
}
