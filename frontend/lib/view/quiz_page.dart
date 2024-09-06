import 'package:flutter/material.dart';
import 'package:frontend/view/widgets/utils/error_dialog.dart';

class QuizPage extends StatelessWidget {
  final TextEditingController controller;
  final Function onGenerateQuiz;
  final Map<String, String>? quiz;
  final bool? isEmptyQuestions;

  const QuizPage({
    super.key,
    required this.controller,
    required this.onGenerateQuiz,
    required this.quiz,
    required this.isEmptyQuestions,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmptyQuestions == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message:
                  'No quiz questions generated. Please enter a valid paragraph.',
            );
          },
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuizCraft',
          style: TextStyle(
              fontFamily: 'Arial', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              SizedBox(
                height: 200, // Set a fixed height for the TextField
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter paragraph',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onGenerateQuiz(),
                child: const Text(
                  'Generate',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (quiz != null) ...[
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: quiz!.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${entry.key}\n${entry.value}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
