import 'package:flutter/material.dart';
import 'package:mathapp/src/models/course.model.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:provider/provider.dart';

class LessonsPage extends StatefulWidget {

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final courseService=Provider.of<CourseService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(courseService.currentCourse),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    (courseService.currentCourse.lessons.length == 0)
                    ?
                    Center(child: Text("No se encontraron lecciones para este curso"))
                    :
                    _tabBar(screenSize, courseService.currentCourse)
                  ],
                ),
              )
            ])
          )
        ],
      ),
    
   );
  }

  Widget _tabBar(Size screenSize, Course course) {
    return Container(
      height: screenSize.height - 300,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [ 
            TabBar(
              indicatorColor: course.color,
              tabs: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Lecciones',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Pruebas',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _lessonsList(course),
                  Center(child: Text('Aquí van los test')),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Container _lessonsList(Course course) {
    return Container(
      child: ListView.builder(
        itemCount: course.lessons.length,
        itemBuilder: (BuildContext context, int i) {
          return _lessonCard(context, course.lessons[i], course.color);
        },
      ),
    );
  }

  Container _lessonCard(BuildContext context, Lesson lesson, Color color) {
    return Container(
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
            offset: Offset(3,6)
          )
        ]
      ),
      child: ListTile(
        leading: Icon(Icons.notes, size: 40, color: color,),
        title: Text(lesson.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        trailing: Icon(Icons.chevron_right),
        subtitle: Text(lesson.description, overflow: TextOverflow.ellipsis,),
        onTap: () {
          Provider.of<CourseService>(context, listen: false).currentLesson = lesson;
          Navigator.pushNamed(context, 'showlesson');
        }
      ),
    );
  }

  SliverAppBar _appBar(Course course) {
    return SliverAppBar(
          backgroundColor: course.color,
          expandedHeight: 300,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.only(bottom: 30, left: 20),
            title: Text(course.name, style: TextStyle(fontSize: 22),),
            background: Icon(Icons.functions_rounded, size: 100, color: Colors.white,),
          ),
        );
  }

 
}