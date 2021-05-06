import 'package:flutter/material.dart';
import 'package:mathapp/src/models/user.model.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:mathapp/src/utils/alerts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userModel = User();
  final formKey = GlobalKey<FormState>();
  final alerts = Alerts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro', style: TextStyle(color: Colors.blue)),
          backgroundColor: Colors.white,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Crear una cuenta',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 30,),
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
        ));
  }

  List<Widget> _createInputs({List inputs}) {
    List<Widget> listInputs = [];
    inputs.forEach((input) {
      listInputs.add(input);
      listInputs.add(SizedBox(
        height: 30,
      ));
    });
    return listInputs;
  }

  _inputUsername() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(220, 220, 220, 0.9),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: "Nombre de usuario",
              border: OutlineInputBorder(borderSide: BorderSide.none)),
          onSaved: (value) => userModel.username = value,
          validator: (value){
            if(value.isEmpty){
              return "El campo usuario es obligatorio";
            }
          },
          ),

    );
  }

  _inputEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(220, 220, 220, 0.9),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: "Correo electrónico",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        onSaved: (value) => userModel.email = value,
        validator: (value){
          if(value.isEmpty){
            return "El campo email es obligatorio";
          }
        },
      ),
    );
  }

  _inputPwd() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(220, 220, 220, 0.9),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        onSaved: (value) => userModel.pwd = value,
        validator: (value){
         if(value.length<8){
           return "Debe tener mas de 8 caracteres";
         }
        },
      ),
    );
  }

  _buttonSave() {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          'Crear cuenta',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
      onTap: () async {
        if (!formKey.currentState.validate()) return;
        final userService = Provider.of<UserService>(context, listen: false);
        formKey.currentState.save();
        final resp = await userService.createUser(userModel);
        if (resp == true) {
          
          alerts.loginAlert(context, 'Correcto',
              "Usuario registrado correctamente", Icons.check, Colors.green);
        } else {
         
        }
      },
    );
  }
}
