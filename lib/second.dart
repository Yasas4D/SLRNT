import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Second extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<Second> {
  final formkey = new GlobalKey<FormState>();
  String email;
  String password;
  List list;

  Future<String> getData() async {
    //var response = await http.get("http://192.168.56.1/myfolder/getdata.php");
    var response = await http.get(
        Uri.encodeFull("http://192.168.56.1/myfolder/getdata.php"),
        headers: {"Accept": "application/json"});
    var extractdata = json.decode(response.body);
    List data;
    data = extractdata;

    final form = formkey.currentState;
    form.save();
    int flag = 0;
    if (validateAndSave()) {
      for (var i = 0; i < data.length; i++) {
        String x = data[i]["name"];
        String y = data[i]["mobile"];

        String em = email;
        String pw = password;

        if ((x == em) && (y == pw)) {
          form.reset();
          Navigator.of(context).push(
            new MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('You Are signed in'),
                  ),
                );
              },
            ),
          );

          break;
        } else {
          flag = flag + 1;
        }
      }

      if (flag == data.length) {
        form.reset();
        Navigator.of(context).push(
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: const Text('Login failed'),
                ),
              );
            },
          ),
        );
      }
    }

    //print(response.body);
    //print(flag);
    return null;
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is Valid');
      print(email);
      print(password);
      return true;
    } else {
      print('Form is Null');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Welcome to Login')),
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Container(
            child: new SingleChildScrollView(
                padding: new EdgeInsets.all(32.0),
                child: new Form(
                  key: formkey,
                  child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new TextFormField(
                          decoration:
                              new InputDecoration(labelText: 'User Name'),
                          validator: (value) => value.isEmpty
                              ? 'User Name Can\'t be empty'
                              : null,
                          onSaved: (value) => email = value,
                        ),
                        new TextFormField(
                          decoration:
                              new InputDecoration(labelText: 'Password'),
                          validator: (value) =>
                              value.isEmpty ? 'Password Can\'t be empty' : null,
                          onSaved: (value) => password = value,
                          obscureText: true,
                        ),
                        new RaisedButton(
                          child: new Text('Login',
                              style: new TextStyle(fontSize: 20)),
                          onPressed: this.getData,
                        ),
                        new RaisedButton(
                          child: new Text('Go to registration'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Third');
                          },
                        )
                      ],
                    ),
                  ),
                )),
          )
        ]));
  }
}
