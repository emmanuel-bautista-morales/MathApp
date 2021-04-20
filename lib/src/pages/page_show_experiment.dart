import 'package:flutter/material.dart';
import 'package:mathapp/src/services/experiment.service.dart';
import 'package:mathapp/src/theme/theme.dart';
import 'package:provider/provider.dart';


class ShowExperimentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final experimentService=Provider.of<ExperimentService>(context);
   
    return Scaffold(
      appBar: AppBar(title: Text("Experimento"),backgroundColor: primaryColor,),
      body: Column(
        children: [
             if(experimentService.isLoanding)
             Center(child: CircularProgressIndicator()),
             if(!experimentService.isLoanding)
             if(experimentService.experiment !=null)
            _cardExperiment(experimentService),
              if(experimentService.experiment==null)
              Center(child: Text("No hay datos...")), 
        ],
      )
     
   );
  }

  Center _cardExperiment(ExperimentService experimentService) {
    return Center(
     child: Container(
        margin: EdgeInsets.all(20),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
             Text(experimentService.experiment.title,style: TextStyle(fontSize: 25),),
             SizedBox(height: 20,),
             Text(experimentService.experiment.content,textAlign: TextAlign.justify,style: TextStyle(fontSize: 17),),
         ],
       ),
     ),
   );
  }
}