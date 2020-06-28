import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bunkx2/Pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.orange,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orangeAccent,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          labelStyle: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  // Text(
                  //   'Bunk-X 2.0',
                  //   style: GoogleFonts.righteous(
                  //       textStyle: TextStyle(fontSize: 50.0)),
                  // ),
                  Container(
                    width: 250.0,
                    height: 250.0,
                    child:
                        Image(image: AssetImage('assets/logo_transparent.png')),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  http.Response response;
  String link;
  String rollno = '';
  String password = '';
  String url =
      'http://studatt-env.eba-xqzxgkvq.us-east-1.elasticbeanstalk.com/?cred=';
  Future<String> getData() async {
    try {
      response = await http.get(Uri.encodeFull(url));
      link = url;
      _loadingInProgress = false;

      url =
          'http://studatt-env.eba-xqzxgkvq.us-east-1.elasticbeanstalk.com/?cred=';
      if (rollno == '' || password == '') {
        _loadingInProgress = false;
        return 'meh';
      }
      if (response.body[1] == '}') {
        return 'meh';
      } else {
        return 'successful';
      }
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  final FocusNode passwordField = FocusNode();

  bool _loadingInProgress = false;
  bool _firstClick = true;
  Map user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          _buildBody(),
          Text(
            'Login',
            style: GoogleFonts.righteous(textStyle: TextStyle(fontSize: 50.0)),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Rollno.",
            ),
            onChanged: (String value) {
              rollno = value;
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordField);
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            focusNode: passwordField,
            decoration: InputDecoration(
              labelText: "password",
            ),
            onChanged: (String value) {
              password = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text('Login'),
            onPressed: () {
              setState(() {
                if (_firstClick == true) {
                  _firstClick = false;
                  url = url + rollno + ' ' + password;
                  _loadingInProgress = true;
                  getData().then((value) {
                    if (value == 'successful') {
                      user = json.decode(response.body);
                      print(response.body);
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage(
                              user: user,
                            );
                          },
                        ),
                      );
                    } else {
                      Alert(
                              context: context,
                              title: "Login Error",
                              desc: "Your Rollno. or password doesnt match!")
                          .show()
                          .then((value) {
                        main();
                      });
                      _loadingInProgress = false;
                      _firstClick = true;
                    }
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loadingInProgress) {
      return new Center(
        child: SpinKitPouringHourglass(
          color: Colors.purple,
          size: 50.0,
        ),
      );
    } else {
      return new Center(
        child: new Text('\n'),
      );
    }
  }
}
