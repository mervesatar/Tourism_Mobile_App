import 'package:flutter/material.dart';
import 'homepage.dart';
import 'signup.dart';
import 'userClass.dart';
import 'authentication.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class Login extends StatefulWidget {
  static String email;

  AuthenticationService autService = new AuthenticationService();

  static userClass newUser = new userClass();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TextEditingController mailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    mailControl.text = Login.email;
  }



  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login Screen'),
      ),
      body: Container(
        child: Center(
          child: isloading
              ? CircularProgressIndicator()
              : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: (MediaQuery.of(context).size.height) / 5,
                  width: (MediaQuery.of(context).size.width) / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                        'Tourism Mobile App',
                        style: TextStyle(
                          fontSize: 35,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.white,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  //obscureText: true,
                  controller: mailControl,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Mail',
                  ),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: passwordControl,
                  obscureText: true,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 8, 80, 8),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  color: Colors.black,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.red,
                  onPressed: () async {
                    if (_connectionStatus == 'ConnectivityResult.none'){
                      print('hi');
                      showSnackBar(context);
                    } else {
                      setState(() {
                        isloading = true;
                      });

                      Login()
                          .autService
                          .signInProccess(
                          mailControl.text, passwordControl.text)
                          .then((value) {
                        print(value.name);

                        setState(() {
                          Login.newUser = value;

                          isloading = false;
                        });

                        print(value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      }).catchError((Error) {
                        print(Error);
                      }); }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 8, 80, 8),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  color: Colors.black,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.red,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signup()));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20.0),
                  ),

                ),
              ),

            ],




          ),
        ),
      ),
    );
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }




    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('You are not connected to internet.'),
      backgroundColor: const Color(0xffae00f0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Try Again',
          textColor: Colors.white,
          onPressed: () {
            print('Done pressed!');
          }),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
