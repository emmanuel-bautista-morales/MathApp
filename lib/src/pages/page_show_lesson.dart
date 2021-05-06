import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowLessonPage extends StatefulWidget {
  @override
  _ShowLessonPageState createState() => _ShowLessonPageState();
}

class _ShowLessonPageState extends State<ShowLessonPage> {
  @override
  void initState() {
    super.initState();
    final courseService = Provider.of<CourseService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);

    courseService.setProgress(
        userService.currentUser.id, courseService.currentLesson.id);
  }

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CourseService>(context);

    Lesson currentLesson = courseService.currentLesson;
    final userService = Provider.of<UserService>(context);
    userService.lastLesson = courseService.currentLesson.id;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${currentLesson.title}",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0.8,
          toolbarHeight: 65,
          iconTheme: IconThemeData(color: Colors.blue),
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [_lessonContent(context, currentLesson), _footer(context)],
        ));
  }

  Container _footer(BuildContext context) {
    final courseService = Provider.of<CourseService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    final lessons = courseService.currentCourse.lessons;
    Lesson nextLesson = null;
    bool isLastLesson = false;

    // identificar la lección siguiente
    if (lessons != null) {
      for (var i = 0; i < lessons.length; i++) {
      if ((lessons[i].id == courseService.currentLesson.id)) {
        if (i < lessons.length - 1) {
          nextLesson = lessons[i + 1];
        } else {
          isLastLesson = true;
          nextLesson = lessons[i];
        }
      }
    }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          !userService.answeredTest
              ? MaterialButton(
                  padding: EdgeInsets.all(7),
                  color: Colors.lightBlue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    !isLastLesson ? "Siguiente lección" : "Hacer la prueba",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (!isLastLesson) {
                      courseService.currentLesson = nextLesson;
                      Navigator.pushReplacementNamed(context, 'showlesson');
                    } else {
                      Provider.of<CourseService>(context, listen: false)
                          .currentTest = courseService.currentCourse.tests[0];
                      Navigator.pushReplacementNamed(context, 'test');
                    }
                  })
              : Container()
        ],
      ),
    );
  }

  Widget _lessonContent(BuildContext context, Lesson lesson) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Html(
                data: lesson.content,
                style: {
                  'p': Style(
                      fontSize: FontSize.rem(1.1),
                      textAlign: TextAlign.justify,
                      lineHeight: LineHeight.number(1.3),
                      color: Color.fromRGBO(0, 0, 0, 0.70)),
                  'li': Style(
                      fontSize: FontSize.em(1.3),
                      textAlign: TextAlign.justify,
                      lineHeight: LineHeight.number(1.3),
                      color: Color.fromRGBO(0, 0, 0, 0.70)),
                  'h1': Style(textAlign: TextAlign.center),
                  'strong': Style(fontSize: FontSize.large)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
