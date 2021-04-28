import 'package:flutter/material.dart';
import 'package:mathapp/src/models/user.model.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:mathapp/src/utils/alerts.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user=User();
final formKey = GlobalKey<FormState>();
final alerts=Alerts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 _contentTitle(),
                 SizedBox(height: 60,),
                 _contentInputs(context),
               ],
            ),
          ),
        ),
      )
   );
  }
Container _contentTitle() {
    return  Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
         Image.network("https://static.vecteezy.com/system/resources/previews/001/209/952/non_2x/math-png.png",width: 100,height: 100,),
          Text("Math App",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
  Form _contentInputs(BuildContext context){
  return  Form(
    key:formKey ,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._crearInputsForm(inputs: [
             _inputEmail(),
             _inputPwd(),
             _buttonLogin(context),
            _buttonRegister()
        ])

    ],),
  );
  }
List<Widget>_crearInputsForm({List inputs}){
  List<Widget>listInputs=[];
  inputs.forEach((input) {
    listInputs.add(input);
    listInputs.add(SizedBox(height: 40,));

   });
   return listInputs;
}
  
  Container _inputEmail() {
    return Container(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Text("Usuario",style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 5,),
      TextFormField(
        decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
        ),
          labelText: 'Ingresa tu email'
        ),
        onSaved: (value)=>user.email=value
        )
  ],),);
  }
  Container _inputPwd(){
    return Container(
     
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contraseña",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          TextFormField(
        decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
        ),
          labelText: 'Ingresa tu contraseña'
        ),
        onSaved: (value)=>user.pwd=value
        )
        ],
      ),
    );
  } 


  

   MaterialButton _buttonLogin(BuildContext context) {
  
     final usuarioService= Provider.of<UserService>(context,listen: false);
    return MaterialButton(
      child: Container(
      
      color: Colors.blue,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Center(child: Text("Iniciar sesión",style: TextStyle(color: Colors.white,fontSize: 18),))),
      onPressed: ()async{
         formKey.currentState.save();
         await usuarioService.login(user);
         if(usuarioService.isAutenticado){
           Navigator.pushReplacementNamed(context, 'courses');
         }else{
           alerts.dangerAlert(context,"Error","Revisa tu email o contraseña e intentalo nuevamente!",Icons.warning,Colors.red);
           print("Usuario no encontrado");
         }

      });
  }

  TextButton _buttonRegister() {
    return TextButton(onPressed: ()=>Navigator.pushNamed(context, 'register'), 
    child: Center(
      child: Text("¿No tienes una cuenta? registrate aqui",style: TextStyle(color: Colors.black),)));
  }
}