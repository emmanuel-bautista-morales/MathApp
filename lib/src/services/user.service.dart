import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mathapp/src/models/user.model.dart';

import '../../appconfig.dart';
import 'package:http/http.dart' as http;
class UserService with ChangeNotifier{
   bool _isAtenticado=false;
   User _currentUser;


   get isAutenticado=>this._isAtenticado;
   User get currentUser=>this._currentUser;

   
   login(User user) async {
    final uri=Uri.http(AppConfig.apiHost, '/api/user/login');
    final response= await http.post(uri, body:jsonEncode( {
      'email': user.email,
      'pwd':user.pwd 
    },
    
    ));
     final convertToUF8=Utf8Codec().decode(response.bodyBytes);
     final respData = json.decode(convertToUF8);
    
    if(respData['status']=='ok'){
     final userResponse=userModelFromJson(convertToUF8);
      _isAtenticado=true;
      this._currentUser=userResponse.data;
      notifyListeners();
    }else{
      _isAtenticado=false;
      notifyListeners();
    }
  
  }
  createUser(User user)async{
    final uri=Uri.http(AppConfig.apiHost, '/api/user/create');
    final response=await http.post(uri,body:  jsonEncode({
      'username':user.username,
      'email':user.email,
      'pwd':user.pwd

    }));
    print(response);
    print(response.statusCode);
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

}