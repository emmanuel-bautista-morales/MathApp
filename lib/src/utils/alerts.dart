import 'package:flutter/material.dart';

class Alerts{
  void dangerAlert(BuildContext context,String title,String content,IconData icono,Color color){
    showDialog(context: context, builder: (_)=>new AlertDialog(
         title: new Column(
           children: [
             Icon(icono,size: 60,color: Colors.red),
             Text(title,style: TextStyle(fontSize: 25),),
             SizedBox(height: 10,),
           ],
         ),
              content: new Text(content,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
              actions: <Widget>[
               new TextButton(
                child: Container(
                color:color,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: new Text("Aceptar",style: TextStyle(color: Colors.white),)),
                onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
            ));
  }
}