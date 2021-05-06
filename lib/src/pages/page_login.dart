import 'package:flutter/material.dart';
import 'package:mathapp/src/models/user.model.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:mathapp/src/utils/alerts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = User();
  final formKey = GlobalKey<FormState>();
  final alerts = Alerts();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // SharedPreferences.setMockInitialValues({});
    
    SharedPreferences.getInstance().then((instance) {
      SharedPreferences prefs = instance;
      bool logged =
          prefs.getBool('logged') != null ? prefs.getBool('logged') : false;
      setState(() {
        if (logged) {
          final userService = Provider.of<UserService>(context, listen: false);
          user.id = prefs.getString('userId');
          user.email = prefs.getString('email');
          user.pwd = prefs.getString('pwd');
          userService.login(user);
          Navigator.pushReplacementNamed(context, 'courses');
        }
        else  {
          loading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('mostrando login...');
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _contentTitle(),
                    SizedBox(
                      height: 60,
                    ),
                    _contentInputs(context),
                  ],
                ),
              ),
            ),
    );
  }

  Container _contentTitle() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20)),
            child: Image(
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Pi-symbol-white.svg/1200px-Pi-symbol-white.svg.png'),
                fit: BoxFit.fill),
          ),
          Text(
            "Math App",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Form _contentInputs(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._crearInputsForm(inputs: [
            _inputEmail(),
            _inputPwd(),
            _buttonLogin(context),
            _buttonRegister()
          ])
        ],
      ),
    );
  }

  List<Widget> _crearInputsForm({List inputs}) {
    List<Widget> listInputs = [];
    inputs.forEach((input) {
      listInputs.add(input);
      listInputs.add(SizedBox(
        height: 20,
      ));
    });
    return listInputs;
  }

  Container _inputEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(220, 220, 220, 0.9),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Correo electrónico'),
          onSaved: (value) => user.email = value),
    );
  }

  Container _inputPwd() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(220, 220, 220, 0.9),
            borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Contraseña'),
            onSaved: (value) => user.pwd = value));
  }

  Widget _buttonLogin(BuildContext context) {
    final usuarioService = Provider.of<UserService>(context, listen: false);
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          'Iniciar sesión',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
      onTap: () async {
        formKey.currentState.save();
        await usuarioService.login(user);
        if (usuarioService.isAutenticado) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', usuarioService.currentUser.id);
          prefs.setString('username', usuarioService.currentUser.username);
          prefs.setString('email', usuarioService.currentUser.email);
          prefs.setString('pwd', usuarioService.currentUser.pwd);
          prefs.setBool('logged', true);
          Navigator.pushReplacementNamed(context, 'courses');
        } else {
          alerts.alerts(
              context,
              "Error",
              "Revisa tu email o contraseña e intentalo nuevamente!",
              Icons.warning,
              Colors.red);
        }
      },
    );
  }

  TextButton _buttonRegister() {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, 'register'),
        child: Center(
            child: Text(
          "¿No tienes una cuenta? registrate aqui",
          style: TextStyle(color: Colors.black),
        )));
  }
}
