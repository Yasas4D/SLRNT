import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(title: new Text('Home')),
        body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/Welcome.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        new Container(
          padding: new EdgeInsets.all(64.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                Text(
                  'Welcome To SLINTEC ',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 40.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // new RaisedButton(
                //     padding: const EdgeInsets.all(16.0),
                //     textColor: Colors.white,
                //     color: Colors.deepOrange,
                //     child: Text("Go to Login"),
                //     onPressed: () {
                //       Navigator.of(context).pushNamed('/Second');
                //     },
                //     shape: new RoundedRectangleBorder(
                //         borderRadius: new BorderRadius.circular(30.0))),
                // new RaisedButton(
                //   child: new Text('Go to registration'),
                //   onPressed: () {
                //     Navigator.of(context).pushNamed('/Third');
                //   },
                // ),
                new Container(
                  padding: EdgeInsets.only(top: 16.0),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Second');
                    },
                    color: Colors.deepOrange,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        // fontFamily: 'Raleway',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 16.0),
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Third');
                    },
                    color: Colors.deepOrange,
                    child: Text(
                      "Registration",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          alignment: Alignment(0.0, 0.0),
        )
      ],
    ));
  }
}
