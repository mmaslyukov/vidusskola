import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidusskola/constants.dart';
import 'package:vidusskola/models/fetch.dart';
import 'package:vidusskola/screens/home/home_screen.dart';
import 'package:vidusskola/models/fetch.dart' as fetcher;
import 'package:vidusskola/secret.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
// class Body extends StatelessWidget {
  AutofillContextAction _autofillContextAction = AutofillContextAction.cancel;
  final _controllerUserName = TextEditingController();
  final _controllerPassword = TextEditingController();

  String _username = "";
  String _password = "";

  // final _formKey = GlobalKey<FormState>();
  // const Body({required Key key}) : super(key: key);
  // const Body({Key key, this.product}) : super(key: key);
  Future<void> _submit() async {
    // await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _autofillContextAction = AutofillContextAction.commit;
    });

    // _username = kUsername;
    // _password = kPassword;
    var auth = await fetcher.login(_username, _password);

    // print('data: $value');
    if (auth != null) {
      var profile = await fetcher.schedule(auth);
      if (profile != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("username", _username);
        prefs.setString("password", _password);

        if (!mounted) return;
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => HomeScreen(profile: profile)));
      }
    }
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      _username = prefs.getString("username");
      _password = prefs.getString("password");
      _controllerUserName.text = _username;
      _controllerPassword.text = _password;
    });

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
        onDisposeAction: _autofillContextAction,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/icons/logo_1.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 40, bottom: 0),
                // padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _controllerUserName,
                  autofillHints: const [AutofillHints.username],
                  onChanged: (value) {
                    _username = value.toString();
                    // log('data: $value');
                    // print("data_ $value");
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter your username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: _controllerPassword,
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                  onChanged: (value) {
                    _password = value.toString();
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 30, bottom: 0),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: kColorTheme,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: _submit,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
