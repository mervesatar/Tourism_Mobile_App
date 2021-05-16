import 'package:flutter/material.dart';
import 'authentication.dart';
import 'login.dart';

class signup extends StatefulWidget {
  AuthenticationService authService = new AuthenticationService();
  @override
  _signup createState() => _signup();
}

class _signup extends State<signup> {
  TextEditingController mailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController surnameControl = new TextEditingController();
  TextEditingController genderControl = new TextEditingController();
  TextEditingController ageControl = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent ,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign Up Screen'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: (MediaQuery.of(context).size.height)/7,
                  width: (MediaQuery.of(context).size.width)/2,

                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text('Personal Informations', style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.white,
                  ),)),
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
                      hintText: 'anilirfanoglu@hotmail.com'),
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
                      hintText: '123456789'),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: nameControl,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'hasan'),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: surnameControl,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'hasan'),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: genderControl,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Gender',
                      hintText: 'male or female'),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: ageControl,
                  decoration: InputDecoration(fillColor: Colors.white,filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: '20'),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                  splashColor: Colors.blueAccent,
                  onPressed: () async {
                    signup()
                        .authService
                        .signupProcess(
                        mailControl.text,
                        passwordControl.text,
                        nameControl.text,
                        surnameControl.text,
                        genderControl.text,
                        ageControl.text,
                        )
                        .then((value) {
                      //Scaffold.of(context).showSnackBar(SnackBar(
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Sign Up Successfully'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2)));

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }).catchError((Error) {
                      print(Error);
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20.0),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                  splashColor: Colors.blueAccent,
                  onPressed: () {


                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },


                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20.0),
                    softWrap: true,
                  ),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
