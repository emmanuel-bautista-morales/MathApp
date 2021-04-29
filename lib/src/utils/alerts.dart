import 'package:flutter/material.dart';

class Alerts{
  void alerts(BuildContext context,String title,String content,IconData icono,Color color){
    showDialog(context: context, builder: (_)=>new AlertDialog(
         title: new Column(
           children: [
             Icon(icono,size: 70,color: color),
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

  void loginAlert(BuildContext context,String title,String content,IconData icono,Color color){
    showDialog(context: context, builder: (_)=>new AlertDialog(
         title: new Column(
           children: [
             Icon(icono,size: 70,color: color),
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
               Navigator.pushNamedAndRemoveUntil(context, 'login',(_)=>false);
              },
            ),
          ],
            ));
  }
}