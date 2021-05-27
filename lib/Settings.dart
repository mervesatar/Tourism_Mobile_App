import 'package:flutter/material.dart';
import 'package:project/MainPage.dart';
import 'authentication.dart';
import 'login.dart';

class update extends StatefulWidget {
  AuthenticationService authService = new AuthenticationService();
  @override
  _update createState() => _update();
}

class _update extends State<update> {
  TextEditingController mailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController surnameControl = new TextEditingController();
  TextEditingController interestControl = new TextEditingController();
  TextEditingController ageControl = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();

    nameControl.text = Login.newUser.name;
    interestControl.text = Login.newUser.interest;
    ageControl.text = Login.newUser.age;
    surnameControl.text = Login.newUser.surname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Update',
          style: TextStyle(
            fontFamily: 'Satisfy',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: (MediaQuery.of(context).size.height) / 7,
                  width: (MediaQuery.of(context).size.width) / 2,
                  child: Center(
                      child: Text(
                    'Please Enter Your Personal Information',
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        //..style = PaintingStyle.stroke
                        //..strokeWidth = 2
                        ..color = Colors.white,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 80,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: nameControl,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: Login.newUser.name),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: surnameControl,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      hintText: Login.newUser.surname),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: interestControl,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Interest',
                      hintText: Login.newUser.interest),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: ageControl,
                  decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: Login.newUser.age),
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
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.greenAccent,
                  onPressed: () async {
                    update()
                        .authService
                        .updateUserInfo(
                          Login.newUser.id,
                          nameControl.text,
                          surnameControl.text,
                          interestControl.text,
                          ageControl.text,
                        )
                        .then((value) {
                      //Scaffold.of(context).showSnackBar(SnackBar(
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Updated Successfully'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2)));
                      Login.newUser.name = nameControl.text;
                      Login.newUser.surname = surnameControl.text;
                      Login.newUser.interest = interestControl.text;
                      Login.newUser.age = ageControl.text;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    }).catchError((Error) {
                      print(Error);
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Satisfy',
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) / 30,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background2.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop))),
      ),
    );
  }
}
