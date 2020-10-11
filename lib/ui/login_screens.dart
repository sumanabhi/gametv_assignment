import 'package:flutter/material.dart';
import 'package:gametv_assignment/widget/bezierContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget build(context) {
    final bloc = Provider.of(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        child: Stack(children: <Widget>[
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: height * .2),
                logo,
                SizedBox(
                  height: 50,
                ),
                emailField(bloc),
                SizedBox(
                  height: 20,
                ),
                passwordField(bloc),
                SizedBox(height: height * .14),
                submitButton(bloc),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  final logo = Hero(
    tag: 'game.tv',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 70.0,
      child: Image.asset(
        'assets/gametv_logo.png',
        color: Colors.black,
      ),
    ),
  );

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              errorText: snapshot.error,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          );
        });
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: bloc.changePassword,
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                child: Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
                onPressed: () async {
                  if (bloc.checkUserData()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('loggedIn', true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    print('Please check your data and Try Again');
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error !!!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Please check your data and Try Again'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                }),
          );
        });
  }
}
