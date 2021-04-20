// To parse this JSON data, do
//
//     final showLessonModel = showLessonModelFromJson(jsonString);

import 'dart:convert';

ShowLessonModel showLessonModelFromJson(String str) => ShowLessonModel.fromJson(json.decode(str));

String showLessonModelToJson(ShowLessonModel data) => json.encode(data.toJson());

class ShowLessonModel {
    ShowLessonModel({
        this.status,
        this.data,
    });

    String status;
    ShowLesson data;

    factory ShowLessonModel.fromJson(Map<String, dynamic> json) => ShowLessonModel(
        status: json["status"],
        data: ShowLesson.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class ShowLesson {
    ShowLesson({
        this.id,
        this.title,
        this.content,
        this.courseId,
    });

    String id;
    String title;
    String content;
    String courseId;

    factory ShowLesson.fromJson(Map<String, dynamic> json) => ShowLesson(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        courseId: json["course_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "course_id": courseId,
    };
}
