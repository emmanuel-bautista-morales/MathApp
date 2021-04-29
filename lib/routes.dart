import 'package:flutter/material.dart';
import 'package:mathapp/src/pages/page_courses.dart';
import 'package:mathapp/src/pages/page_lessons.dart';
import 'package:mathapp/src/pages/page_login.dart';
import 'package:mathapp/src/pages/page_register_user.dart';
import 'package:mathapp/src/pages/page_show_lesson.dart';
import 'package:mathapp/src/pages/page_test.dart';


Map<String,WidgetBuilder> routes(){
  return <String,WidgetBuilder>{
   'login': (BuildContext context)=>LoginPage(),
   'register':(BuildContext context)=>RegisterPage(),
   'courses':(BuildContext context)=>CoursesPage(),
   'lessons':(BuildContext context)=>LessonsPage(),
   'showlesson':(BuildContext context)=>ShowLessonPage(),
   'test':(BuildContext context)=>TestPage()
     };
}