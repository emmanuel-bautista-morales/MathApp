class Answer {
  String id;
  String answer;
  bool correct;

  Answer({
    this.id,
    this.answer,
    this.correct
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json['id'],
    answer: json['answer'],
    correct: int.parse(json['correct']) == 0 ? false : true
  );
}