import 'package:mathapp/src/models/answer.model.dart';

class Question {
  String id;
  String question;
  int testId;
  List<Answer> answers;
  bool _answered = false;

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

  set answered(bool value) {
    this._answered = value;
  }

  bool get answered => this._answered;
}