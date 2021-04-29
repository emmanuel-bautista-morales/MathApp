import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mathapp/src/models/course.model.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/user.service.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final coursesService = Provider.of<CourseService>(context);
    final random = new math.Random();
    final Lesson lastLesson = Lesson();

    if (!userService.isLoading && userService.lastLesson != '0') {
      coursesService.courses.forEach((c) {
        c.lessons.forEach((l) {
          if (l.id == userService.lastLesson) {
            lastLesson.id = l.id;
            lastLesson.title = l.title;
            lastLesson.content = l.content;
            lastLesson.description = l.description;
            lastLesson.courseId = l.courseId;
          }
          return;
        });
      });
    }

    return (coursesService.isLoading || userService.isLoading)
        ? Scaffold(
          body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: _appBar(random, userService),
            body: _body(
                context, coursesService, userService, random, lastLesson));
  }

  Widget _body(BuildContext context, CourseService coursesService,
      UserService userService, math.Random random, Lesson lastLesson) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  'Elige un curso',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                )),
            _courseSwiper(context, coursesService.courses),
            SizedBox(
              height: 30,
            ),
            _lastLessonCard(
                userService, random, lastLesson, coursesService, context),
          ],
        ),
      ),
    );
  }

  Widget _lastLessonCard(UserService userService, math.Random random,
      Lesson lastLesson, CourseService coursesService, BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                'Continua aprendiendo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 15),
            userService.lastLesson != null &&
                    userService.lastLesson == '0'
                ? Text('Aún no has comenzado un curso')
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 20),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(3, 6))
                        ]),
                    child: ListTile(
                        leading: Icon(
                          Icons.list,
                          size: 40,
                          color: Color.fromRGBO(random.nextInt(200),
                              random.nextInt(200), random.nextInt(200), 1),
                        ),
                        title: Text(
                          lastLesson.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: Icon(Icons.chevron_right),
                        subtitle: Text(
                          lastLesson.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          coursesService.currentLesson = lastLesson;
                          Navigator.pushNamed(context, 'showlesson');
                        }),
                  ),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget _appBar(math.Random random, UserService userService) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton(
          child: Center(
              child: Transform.rotate(
                  angle: math.pi / 2, child: Icon(Icons.keyboard_control))),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: MaterialButton(
                  child: Text('Cerrar sesión'),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('userId', '');
                    prefs.setString('username', '');
                    prefs.setString('email', '');
                    prefs.setString('pwd', '');
                    prefs.setBool('logged', false);
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              )
            ];
          },
        ),
        SizedBox(width: 10)
      ],
      title: Row(children: [
        CircleAvatar(
          maxRadius: 15,
          backgroundColor: Color.fromRGBO(
              random.nextInt(200), random.nextInt(200), random.nextInt(200), 1),
          child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(width: 20),
        Text(
          userService.currentUser.username,
          style: TextStyle(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        )
      ]),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Column _searchBar() {
    return Column(
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Text(
              'Aprende De Una Manera Diferente',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            )),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   decoration: BoxDecoration(
        //       color: Color.fromRGBO(220, 220, 220, 0.8),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: TextField(
        //     decoration: InputDecoration(
        //         border: InputBorder.none,
        //         hintText: 'Buscar',
        //         prefixIcon: Icon(Icons.search)),
        //   ),
        // ),
      ],
    );
  }

  Widget _courseSwiper(BuildContext context, List<Course> courses) {
    final coursesService = Provider.of<CourseService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 350,
      child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: courses[index].courseColor),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Center(
                        child: Icon(
                      IconData(courses[index].icon,
                          fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 150,
                    )),
                  ),
                  Text(
                    courses[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      coursesService.currentCourse = courses[index];
                      Navigator.pushNamed(context, 'lessons');
                    },
                    child: Text('Ir al curso'),
                  )
                ],
              ),
            );
          },
          itemCount: courses.length,
          viewportFraction: 0.85,
          scale: 0.9),
    );
  }
}
