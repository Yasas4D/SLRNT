import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Third extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegPageState();
}

class _RegPageState extends State<Third> {
  final formkey = new GlobalKey<FormState>();
  String email;
  String password;
  String university;
  String tPnumber;

  void addtData() {
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

    var url = "http://192.168.56.1/myfolder/signup.php";
    final form = formkey.currentState;
    form.save();

    if (validateAndSave()) {
      print('validate and save');
      try {
        http.post(url, body: {"name": email, "mobile": password});
        print("Sucessfully added");
        form.reset();
        Navigator.of(context).push(
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: const Text('Sucessfully Registerd'),
                ),
                body: Text('Go Back to login',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none, fontSize: 15.0)),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Registration')),
        body: new Container(
          child: new SingleChildScrollView(
              padding: new EdgeInsets.all(32.0),
              child: new Form(
                key: formkey,
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'User Name'),
                        validator: (value) =>
                            value.isEmpty ? 'User Name Can\'t be empty' : null,
                        onSaved: (value) => email = value,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Password'),
                        validator: (value) =>
                            value.isEmpty ? 'Password Can\'t be empty' : null,
                        onSaved: (value) => password = value,
                        obscureText: true,
                      ),
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Univercity'),
                        validator: (value) =>
                            value.isEmpty ? 'Can\'t be empty' : null,
                        onSaved: (value) => university = value,
                      ),
                      new TextFormField(
                        decoration:
                            new InputDecoration(labelText: 'Telephone Number'),
                        validator: (value) =>
                            value.isEmpty ? 'TP Can\'t be empty' : null,
                        onSaved: (value) => tPnumber = value,
                      ),
                      new RaisedButton(
                        child: new Text('Register',
                            style: new TextStyle(fontSize: 20)),
                        onPressed: addtData,
                      ),
                      new RaisedButton(
                        child: new Text('Go to Login'),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/Second', (Route<dynamic> route) => false);
                        },
                      ),
                      new RaisedButton(
                        child: new Text('Go to Home'),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/Home', (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}
