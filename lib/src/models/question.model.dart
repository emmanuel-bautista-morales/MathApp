import 'package:mathapp/src/models/answer.model.dart';

class Question {
  String id;
  String question;
  int testId;
  List<Answer> answers;

  Question(
    {this.id,
    this.question,
    this.testId,
    this.answers}
  );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    question: json['question'],
    testId: int.parse(json['test_id']),
    answers: List<Answer>.from(json['answers'].map((a) => Answer.fromJson(a)))
  );
}