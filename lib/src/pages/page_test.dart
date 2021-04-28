import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:mathapp/src/models/answer.model.dart';

import 'package:mathapp/src/models/test.model.dart';
import 'package:mathapp/src/services/course.service.dart';
import 'package:mathapp/src/services/user.service.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool respuesta;
  List<String> lista = [];
  int _index = -1;
  List<Answer> li = [];
  bool testValid = true;
  List<Map<String, dynamic>> questions = [];
  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<CourseService>(context).isLoading;
    final currentTest = Provider.of<CourseService>(context).currentTest;

    if (questions.length == 0) {
      currentTest.questions.forEach((q) {
        questions.add({"id": q.id, "question": q.question, "correct": false});
      });
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "Prueba",
            style: TextStyle(color: Colors.blue),
          ),
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
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(
                currentTest.instructions,
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentTest.questions.length,
                  itemBuilder: (BuildContext context, int i) {
                    li = currentTest.questions[i].answers;

                    return Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        title: Text(
                            "${i + 1}. ${currentTest.questions[i].question}"),
                        subtitle: _cardAnswer(currentTest, i, questions),
                      ),
                    );
                  },
                ),
              ),
              MaterialButton(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Text(
                        "Enviar todo y terminar",
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: () {
                    //instruccion para guardar en la bd
                    setState(() {
                      currentTest.questions.forEach((q) {
                        if (!q.answered) {
                          testValid = false;
                          return;
                        }
                      });
                      _showConfirmDialog(
                          context, currentTest, loading, questions);
                    });
                  })
            ],
          ),
        ));
  }

  Future _showConfirmDialog(BuildContext context, Test currentTest,
      bool isLoading, List<Map<String, dynamic>> questions) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('¿Desea enviar su prueba?')],
            ),
            actions: [
              MaterialButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    if (testValid) {
                      int cont = 0;

                      questions.forEach((q) {
                        if (q['correct']) {
                          cont++;
                        }
                      });

                      final courseProvider =
                          Provider.of<CourseService>(context, listen: false);
                      courseProvider.testScore(int.parse(currentTest.id),
                          ((cont * 100) / currentTest.questions.length));
                          final userService = Provider.of<UserService>(context, listen: false);
                      userService.answeredTest = true;
                      currentTest.questions.forEach((q) {
                        q.answered = false;
                      });
                      Navigator.of(context).pushReplacementNamed('courses');

                      
                    } else {
                      Navigator.of(context).pop();
                      _showErrorDialog(context);
                    }
                  }),
              MaterialButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  Future _showLoadingDialog(BuildContext context, bool isLoading) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (isLoading
                    ? CircularProgressIndicator()
                    : (Text('Prueba enviada')))
              ],
            ),
            actions: [
              MaterialButton(
                  child: Text('Aceptar'),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('courses'))
            ],
          );
        });
  }

  Future _showErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Debe llenar todos los cambos'),
                Icon(Icons.error, size: 60, color: Colors.red)
              ],
            ),
            actions: [
              MaterialButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  ListView _cardAnswer(
      Test currentTest, int i, List<Map<String, dynamic>> questions) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        lista = []; //limpiarmos el arreglo
        li.forEach((element) {
          //agregamos elementos al array
          lista.add(element.answer);
        });
        return FlutterRadioGroup(
            titles: lista,
            defaultSelected: _index,
            orientation: RGOrientation.VERTICAL,
            onChanged: (index) {
              setState(() {
                currentTest.questions[i].answered = true;
                if (currentTest.questions[i].answers[index].correct) {
                  questions.forEach((q) {
                    if (q['id'] == currentTest.questions[i].id) {
                      q['correct'] = true;
                      return;
                    }
                  });
                } else {
                  questions.forEach((q) {
                    if (q['id'] == currentTest.questions[i].id) {
                      q['correct'] = false;
                      return;
                    }
                  });
                }
                _index = index;
                testValid = true;
              });
            });
      },
    );
  }
}
