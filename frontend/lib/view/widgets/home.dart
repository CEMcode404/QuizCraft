import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

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
            Image.asset('images/quiz.png', width: 300),
            Padding(padding: EdgeInsets.all(16.0)),
            const Text(
              'Transform your notes into Quizzes!',
              style:
                  TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.italic),
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
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
