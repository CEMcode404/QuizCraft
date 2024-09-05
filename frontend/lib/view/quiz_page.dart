import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final TextEditingController controller;
  final Function onGenerateQuiz;
  final Map<String, String>? quiz;

  const QuizPage({
    super.key,
    required this.controller,
    required this.onGenerateQuiz,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizCraft'),
        backgroundColor: Colors.lightBlue[50],
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
                child: const Text('Generate'),
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
      backgroundColor: Colors.lightBlue[50],
    );
  }
}
