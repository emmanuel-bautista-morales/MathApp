import 'package:flutter/material.dart';
import 'package:mathapp/src/models/course.model.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/models/test.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/user.service.dart';
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
                // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                  course.tests.length > 0 ?
                  _testsList(course):
                  Container()
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _lessonsList(Course course) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: EdgeInsets.only(bottom: 50),
      width: double.infinity,
      child: ListView.builder(
        itemCount: course.lessons.length,
        itemBuilder: (BuildContext context, int i) {
          return _card(context, course.lessons[i], course.color, Icons.notes);
        },
      ),
    );
  }

  Container _testsList(Course course) {
    final userService = Provider.of<UserService>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: course.tests.length,
        itemBuilder: (BuildContext context, int i) {
          return _card(context, course.tests[i], course.color, Icons.notes, testLoked: userService.answeredTest);
        },
      ),
    );
  }

  Container _card(BuildContext context, dynamic object, Color color, IconData icon, {
    bool testLoked
  }) {
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
        leading: Icon(icon, size: 40, color: color,),
        title: Row(
          children: [
            Text(object is Lesson ? object.title : 'Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            object is Test && testLoked
            ?
            Text(' (Bloqueada)', style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),):
            Text('')
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        subtitle: Text(object is Lesson ? object.description : 'Pon a prueba tus conocimientos', overflow: TextOverflow.ellipsis,),
        onTap: () {
          if (object is Lesson) {
            Provider.of<CourseService>(context, listen: false).currentLesson = object;
            Navigator.pushNamed(context, 'showlesson');
          }
          if(object is Test && !testLoked){
            Provider.of<CourseService>(context,listen: false).currentTest=object;
            Navigator.pushNamed(context, 'test');
          }
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