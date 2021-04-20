import 'package:flutter/material.dart';
import 'package:mathapp/src/pages/page_courses.dart';
import 'package:mathapp/src/pages/page_lessons.dart';
import 'package:mathapp/src/pages/page_progress.dart';
import 'package:mathapp/src/pages/page_show_experiment.dart';
import 'package:mathapp/src/pages/page_show_lesson.dart';


Map<String,WidgetBuilder> routes(){
  return <String,WidgetBuilder>{
   'courses':(BuildContext context)=>CoursesPage(),
   'lessons':(BuildContext context)=>LessonsPage(),
   'showlesson':(BuildContext context)=>ShowLessonPage(),
   'showExperiment':(BuildContext context)=>ShowExperimentPage(),
   'progress':(BuildContext context)=>ProgressPage()
  };
}