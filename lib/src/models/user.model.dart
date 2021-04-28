// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.status,
        this.data,
    });

    String status;
    User data;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: User.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class User {
    User({
        this.id,
        this.username,
        this.email,
        this.pwd,
        this.answeredTests,
        this.lastLesson,
    });

    String id;
    String username;
    String email;
    String pwd;
    List<dynamic> answeredTests;
    String lastLesson;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        pwd: json["pwd"],
        answeredTests: List<dynamic>.from(json["answered_tests"].map((x) => x)),
        lastLesson: json["last_lesson"] != null ? json["last_lesson"].toString(): "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "pwd": pwd,
        "answered_tests": List<dynamic>.from(answeredTests.map((x) => x)),
        "last_lesson": lastLesson,
    };
}
