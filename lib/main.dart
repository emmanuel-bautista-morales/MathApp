import 'package:flutter/material.dart';
import 'package:mathapp/routes.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/experiment.service.dart';
import 'package:mathapp/src/services/lesson.service.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CourseService()),
        ChangeNotifierProvider(create: (_)=>LessonService(),),
        ChangeNotifierProvider(create: (_)=>ExperimentService())
      ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'courses',
        routes: routes(),
      ),
    );
  }
}