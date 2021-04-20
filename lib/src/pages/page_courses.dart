import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mathapp/src/models/course.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:provider/provider.dart';


class CoursesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final coursesService=Provider.of<CourseService>(context);
   
   
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              maxRadius: 15,
              backgroundImage: NetworkImage('https://heraldodemexico.com.mx/u/fotografias/m/2021/3/26/f608x342-344877_374600_0.jpg'),
            ),
            SizedBox(width: 10),
            Icon(Icons.settings, color: Colors.black, size: 30,)
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white, 
        elevation: 0,
      ),
      body: 
          (coursesService.isLoading)
          ?
          Center(child: CircularProgressIndicator())
          :
          SingleChildScrollView(
            child: Column(
              children: [
                _searchBar(),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text('Elige un curso', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start,)),
                _courseSwiper(context,coursesService.courses),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Continua aprendiendo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start,)),
              ],
            ),
          )
   );
  }

  Column _searchBar() {
    return Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Text('Aprende De Una Manera Diferente', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.start,)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 0.8),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar',
                      prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ),
              ],
            );
  }

  

  Widget _courseSwiper(BuildContext context, List<Course> courses) {
    final coursesService=Provider.of<CourseService>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 350,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: courses[index].courseColor
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: Icon(
                      IconData(courses[index].icon, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                      size: 150,
                    )
                  ),
                ),
                Text(
                  courses[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: (){
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
        scale: 0.9
      ),
    );
  }
}