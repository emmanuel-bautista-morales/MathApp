import 'package:flutter/material.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/lesson.service.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:mathapp/src/theme/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';


class ProgressPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userService=Provider.of<UserService>(context);
    final lessonService=Provider.of<LessonService>(context);
    print(lessonService.lessons.length);
  
    return Scaffold(
      appBar: AppBar(title: Text("Mi progreso"),backgroundColor: primaryColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mi progreso",style: TextStyle(fontSize: 20),),
            SizedBox(height: 40,),
            CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 20.0,
                percent: double.parse(userService.currentUser.lastLesson) / 10,
                center: new Text("${double.parse(userService.currentUser.lastLesson) * 10}%"),
                progressColor: Colors.green,
                ),
          ],
        ),
      )
   );
  }
}