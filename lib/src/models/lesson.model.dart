
import 'dart:convert';



LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
    LessonModel({
        this.status,
        this.data,
    });

    String status;
    List<Lesson> data;

    factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        status: json["status"],
        data: List<Lesson>.from(json["data"].map((x) => Lesson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Lesson {
    Lesson({
        this.id,
        this.title,
        this.content,
        this.courseId,
      
        this.description
    });

    String id;
    String title;
    String content;
    String courseId;
   
    String description;

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        courseId: json["course_id"],
        description: json['description'],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "course_id": courseId,
    };
}
