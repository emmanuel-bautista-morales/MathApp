
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/models/test.model.dart';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
    CourseModel({
        this.status,
        this.data,
    });

    String status;  
    List<Course> data;
    

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        status: json["status"],
        data: List<Course>.from(json["data"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Course {
    Course({
        this.id,
        this.name,
        this.lessons,
        this.icon,
        this.tests
    });

    String id;
    String name;
    List<Lesson> lessons;
    List<Test> tests;
    int icon;
    Color color;

    get courseColor => this.color;
    set courseColor(Color c) {
      this.color = c;
    }

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        icon: int.parse(json["icon"]),
        lessons: List<Lesson>.from(json['lessons'].map((l) => Lesson.fromJson(l))),
        tests: List<Test>.from(json["tests"].map((t) => Test.fromJson(t)))
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
