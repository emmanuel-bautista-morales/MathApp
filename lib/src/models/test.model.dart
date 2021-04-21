import 'package:mathapp/src/models/question.model.dart';

class Test {
    Test({
        this.id,
        this.instructions,
        this.typeTestId,
        this.courseId,
        this.questions
    });

    String id;
    String instructions;
    int typeTestId;
    int courseId;
    List<Question> questions;

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        instructions: json["instructions"],
        typeTestId: int.parse(json["type_test_id"]),
        courseId: int.parse(json["course_id"]),
        questions: List<Question>.from(json['questions'].map((q) => Question.fromJson(q)))
    );
}
