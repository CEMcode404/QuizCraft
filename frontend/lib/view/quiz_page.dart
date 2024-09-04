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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('QuizCraft'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter paragraph",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                expands: true,
                scrollPhysics: const BouncingScrollPhysics(),
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
              Expanded(
                child: SingleChildScrollView(
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
              ),
            ],
          ],
        ),
      ),
    );
  }
}
