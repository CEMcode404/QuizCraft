import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/controller/quiz_controller.dart';
import 'package:frontend/view/quiz_page.dart';
import 'package:frontend/model/quiz_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizCraft',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QuizCraft',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyQuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                iconColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 30,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }
}

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({super.key});

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  final TextEditingController _controller = TextEditingController();
  final QuizController _quizController = QuizController();
  QuizModel? _quizModel;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generateQuiz() async {
    try {
      final quizModel = await _quizController.generateQuiz(_controller.text);
      setState(() {
        _quizModel = quizModel;
      });
    } catch (e) {
      log('Error generating quiz: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return QuizPage(
      controller: _controller,
      onGenerateQuiz: _generateQuiz,
      quiz: _quizModel?.questionsAndAnswers,
    );
  }
}
