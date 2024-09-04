class QuizModel {
  final Map<String, String> questionsAndAnswers;

  QuizModel({required this.questionsAndAnswers});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questionsAndAnswers: Map<String, String>.from(json['q_and_a']),
    );
  }
}
