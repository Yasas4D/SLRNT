import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  List list;
  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

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

    for (var i = 0; i < data.length; i++) {
      String x = data[i]["name"];
      String y = data[i]["mobile"];

      String em = _email;
      String pw = _password;

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

    //print(response.body);
    //print(flag);
    return null;
  }

  void addtData() {
    bool validateAndSave() {
      final form = formkey.currentState;
      if (form.validate()) {
        form.save();
        print('Form is Valid');
        print(_email);
        print(_password);
        return true;
      } else {
        print('Form is Null');
        return false;
      }
    }

    var url = "http://192.168.56.1/myfolder/signup.php";
    final form = formkey.currentState;
    form.save();

    if (validateAndSave()) {
      print('validate and save');
      try {
        http.post(url, body: {"name": _email, "mobile": _password});
        print("Sucessfully added");
        form.reset();
        Navigator.of(context).push(
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: const Text('Sucessfully Registerd'),
                ),
                body: Text('Go Back to login'),
              );
            },
          ),
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('Unsecess');
    }
  }

  void moveToRegister() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Welcome To SLERI'),
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/back3.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Container(
              child: new SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: new Form(
                  key: formkey,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs() + buildSubmitButtons(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'User Name'),
        validator: (value) =>
            value.isEmpty ? 'User Name Can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password Can\'t be empty' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20)),
          onPressed: this.getData,
        ),
        new FlatButton(
          child: new Text('Create an Account',
              style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        new RaisedButton(
          child:
              new Text('Create an Account', style: new TextStyle(fontSize: 20)),
          onPressed: addtData,
        ),
        new FlatButton(
          child: new Text('Have an Account? Login',
              style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}

//how to remove soft keybord from flutter focus
//how to add a footer
