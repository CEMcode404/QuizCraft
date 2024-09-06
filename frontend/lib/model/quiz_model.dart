class QuizModel {
  final Map<String, String> questionsAndAnswers;
  final bool isEmptyQuestions;

  QuizModel(
      {required this.questionsAndAnswers, required this.isEmptyQuestions});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questionsAndAnswers: Map<String, String>.from(json['q_and_a']),
      isEmptyQuestions: json['isEmptyQuestions'] as bool,
    );
  }
}
