import 'package:flutter/material.dart';
import 'package:mathapp/src/theme/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ProgressPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mi progreso"),backgroundColor: primaryColor,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Progreso del curso",style: TextStyle(fontSize: 20),),
            SizedBox(height: 40,),
            CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 15.0,
                percent: 1,
                center: new Text("100%"),
                progressColor: Colors.green,
                ),
          ],
        ),
      )
   );
  }
}