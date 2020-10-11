import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/provider.dart';
import 'ui/login_screens.dart';
import 'ui/home_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<bool> _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = _checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      title: 'GameTv',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: Scaffold(
          body: FutureBuilder<bool>(
              future: _isLoggedIn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return HomePage();
                } else {
                  return LoginScreen();
                }
              })),
    ));
  }
}

Future<bool> _checkUserLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences
      .getBool('loggedIn'); //  Just a get method from shared preferences
}
