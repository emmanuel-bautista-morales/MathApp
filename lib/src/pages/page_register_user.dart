
import 'package:flutter/material.dart';
import 'package:mathapp/src/models/user.model.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:mathapp/src/theme/theme.dart';
import 'package:mathapp/src/utils/alerts.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userModel=User();
   final formKey = GlobalKey<FormState>();
   final alerts=Alerts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(backgroundColor: primaryColor,),
      body: SafeArea(
        
              child: SingleChildScrollView(
             child: Column(
          children: [
            Container(
                height: 200,
                width: double.infinity,
                color: primaryColor,
                child: Center(child: Text("CREA UNA CUENTA",style: TextStyle(color: Colors.white,fontSize: 25),)),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Form(
                  key:formKey ,
                    child: Column(
                    
                     children: [
                   ..._createInputs(inputs: [
                      _inputUsername(),
                      _inputEmail(),
                      _inputPwd(),
                      _buttonSave()
                    
                     ]),
                     ],
                  ),
                ),
            ),
          ],
        ),
              ),
      )
   );
  }

  List<Widget>_createInputs({List inputs}){
    List<Widget>listInputs=[];
    inputs.forEach((input) {
     listInputs.add(input);
     listInputs.add(SizedBox(height: 20,));

    });
    return listInputs;
  } 

  _inputUsername() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
       labelText: "Ingresa tu username",
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
     ),
      onSaved: (value)=>userModel.username=value
     
    );
  }

  _inputEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
      labelText: "Ingresa tu email",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
     ),
      onSaved: (value)=>userModel.email=value,
    );
  }

  _inputPwd() {
    return TextFormField(
    obscureText: true,
      decoration: InputDecoration(
      labelText: "Ingresa tu contraseña",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
     ),
     onSaved: (value)=>userModel.pwd=value,
    );
  }

  _buttonSave() {
    return MaterialButton(
      color: primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
      width: double.infinity,
        child: Center(child: Text("Registrar",style: TextStyle(color: Colors.white,fontSize: 15),)),),
      onPressed: ()async{
        final userService=Provider.of<UserService>(context,listen: false);
       formKey.currentState.save();
       final resp=await userService.createUser(userModel);
       print(userModel.username);
       print(resp);
       if(resp==true){
         print("si");
         alerts.dangerAlert(context, 'Correcto', "Usuario registrado correctamente", Icons.add, Colors.green);
       }else{
         print("error");
       }
      }
      );
  }
}