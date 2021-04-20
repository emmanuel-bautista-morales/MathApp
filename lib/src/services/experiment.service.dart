import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mathapp/appconfig.dart';
import 'package:mathapp/src/models/show_experiment.model.dart';
import 'package:http/http.dart' as http;

final path="/api/experiment";
final endpoint="show";
class ExperimentService with ChangeNotifier{
  Experiment experiment;
  int _idLesson=0;
  bool _isLoanding=true;
  

  set idLesson(int valor){
    this._idLesson=valor;
    // showExperiment();
    notifyListeners();

  }
  get isLoanding=>this._isLoanding;
  get idLesson=>this._idLesson;
 


  showExperiment()async{
   if(this.experiment!=null){
     return this.experiment=null;
   }
   final uri=Uri.http(AppConfig.apiHost, "$path/$endpoint/$_idLesson");
   final resp= await http.get(uri);
   try{
      final convertTof8=Utf8Codec().decode(resp.bodyBytes);
      final respData = json.decode(convertTof8);
      if(respData["status"]=="ok"){
     
      final experimentResponse=showExperimentModelFromJson(convertTof8);
       this.experiment=experimentResponse.data;
       this._isLoanding=false;
     }else{
     this._isLoanding=false;
     }
   }catch(e){

   }
   
   notifyListeners();
  }
}