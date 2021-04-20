import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:mathapp/appconfig.dart';
import 'package:mathapp/src/models/lesson.model.dart';
import 'package:mathapp/src/models/show_lesson.model.dart';

  final pathCourse="/api/course";
  final pathLesson="/api/lesson";
 
  
class LessonService with ChangeNotifier{

//variables
  List<Lesson>lessons=[];
  ShowLesson lesson;
  int _idCourse=0;
  int _idLesson=0;
  bool _isLoanding=true;
  bool _isLoanding2=true;
  bool _error=false;
  String _nameLesson="";

set idCourse(int valor){
  this._idCourse=valor;
  // getLessons();
  notifyListeners();
}
set idLesson(int valor){
  this._idLesson=valor;
  // showLesson();
  notifyListeners();
}
set nameLesson(String valor){
  this._nameLesson=valor;
  notifyListeners();
}
  
  get idLesson=>this._idLesson;
  get idCourse=>this._idCourse;
  get nameLesson=>this._nameLesson;
  get isLoandig=>this._isLoanding;
  get isLoandig2=>this._isLoanding2;
  get error=>this._error;
  

  //obtenemos todas las lecciones por el id del curso
  getLessons()async{
   
    if(this.lessons.length>0){
      this._isLoanding=false;
      this.lessons.clear();
    }
    final uri=Uri.http(AppConfig.apiHost,"$pathCourse/$_idCourse/lessons");

    final resp=await http.get(uri);
    try{
      final convertToUF8=Utf8Codec().decode(resp.bodyBytes);
      final respData = json.decode(convertToUF8);
       if(respData["status"]=="ok"){
        _error=false;
        final lessonResponse=lessonModelFromJson(convertToUF8);
        this.lessons.addAll(lessonResponse.data);
        _isLoanding=false;
       }else{
        _error=true;
     }
    }catch(e){}
    notifyListeners();
  }
//mostrar una leccion por su id
  showLesson()async{
    final uri=Uri.http(AppConfig.apiHost, "$pathLesson/show/$_idLesson");
    final resp=await http.get(uri);
    try{

      final convertToUF8=Utf8Codec().decode(resp.bodyBytes);
      final respData = json.decode(convertToUF8);
      if(respData["status"]=="ok"){
        final lessonResponse=showLessonModelFromJson(convertToUF8);
        this.lesson=lessonResponse.data;
        _isLoanding2=false;
       }
    }catch(e){}
      notifyListeners();

  }


}