

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mathapp/appconfig.dart';
import 'package:mathapp/src/models/course.model.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/models/test.model.dart';

final path="/api/course/all";
class CourseService with ChangeNotifier{
  
  bool _isLoading=true;
  List<Course>courses=[];
  Course _currentCourse;
  Lesson _currentLesson;
  Test _currentTest;

  CourseService(){
    getCourses();
  }

  get isLoading => this._isLoading;

  set currentCourse(Course course) {
    this._currentCourse = course;
    notifyListeners();
  }

  Course get currentCourse => this._currentCourse;

  set currentLesson(Lesson lesson) {
    this._currentLesson = lesson;
    notifyListeners();
  }

  Lesson get currentLesson => this._currentLesson;

  set currentTest(Test test) {
    this._currentTest = test;
    notifyListeners();
  }

  Test get currentTest => this._currentTest;

  getCourses() async {
    final uri=Uri.http(AppConfig.apiHost, path);
    final response=await http.get(uri,headers: {
      'Content-Type':'application/json',
    });
    final dataConvertTof8=Utf8Codec().decode(response.bodyBytes);
    final courseResponse=courseModelFromJson(dataConvertTof8).data;

    courseResponse.forEach((course) { 
      final random = new Random();
      course.courseColor = Color.fromRGBO(random.nextInt(200), random.nextInt(200), random.nextInt(200), 1);
      this.courses.add(course);
    });

    this._isLoading=false;
    notifyListeners();
  }

}