import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:mathapp/src/models/answer.model.dart';

import 'package:mathapp/src/models/test.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:provider/provider.dart';


class TestPage extends StatefulWidget {

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool respuesta;
  List<String>lista=[];
  int _index = -1;
  List<Answer> li=[];
  @override
  Widget build(BuildContext context) {
    final currentTest=Provider.of<CourseService>(context).currentTest.id;
    final courseService=Provider.of<CourseService>(context).currentCourse.tests[int.parse((currentTest))-1];
    return Scaffold(
      backgroundColor: Colors.grey[200],
     appBar: AppBar(
        title: Text("Test", style: TextStyle(color: Colors.blue),) 
        ,backgroundColor: Colors.white, 
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
      body:Column(
        children: [
          Text(courseService.instructions,style: TextStyle(fontSize: 20),),
          ListView.builder(
            shrinkWrap: true,
            itemCount: courseService.questions.length,
            itemBuilder: (BuildContext context, int i){
              li=courseService.questions[i].answers;
             
              return Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                  title: Text("${i+1}. ${courseService.questions[i].question}"),
                  subtitle: _cardAnswer(courseService, i),
                  
                ),
              );
            },
          ),
          MaterialButton(
            child: Container(
              padding: EdgeInsets.all(10),
             color: Colors.blue,
              child: Text("Enviar todo y terminar",style: TextStyle(color: Colors.white),)),
            onPressed: (){
              //instruccion para guardar en la bd
            })
        ],
      )
   );
  }

  ListView _cardAnswer(Test courseService, int i) {
    return ListView.builder(
            
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              lista=[];//limpiarmos el arreglo
              li.forEach((element) {//agregamos elementos al array
               lista.add(element.answer);
              });
            return FlutterRadioGroup(
                titles: lista,
                defaultSelected: _index,
                orientation: RGOrientation.VERTICAL,
                onChanged: (index) {
                  setState(() {
                      print(courseService.questions[i].answers[index].correct);
                    _index = index;
                  });
                });
           },
          );
  }

  
}