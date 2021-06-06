import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Settings/update_profile.dart';
import 'package:project/language/test2.dart';
import 'package:get/get.dart';

import 'change_theme_button.dart';

class SettingsOnePage extends StatefulWidget {
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  String userName = "";

  @override
  void initState() {
    super.initState();

    /* FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        print(user);
      } else {
        print('User is signed in!');
     
      }
      userName=user.email;
       print(userName);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'settings'.tr,
        ),
        actions: <Widget>[
          ChangeThemeButton(),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProfile()));
                    },
                    title: Text(
                      '$userName',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: CircleAvatar(),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(userName),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                        ),
                        title: Text('change_password'.tr),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change password
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                        ),
                        title: Text('change_language'.tr),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Test2()));
                        },
                      ),
                      _buildDivider(),
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                        ),
                        title: Text('change_location'.tr),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          //open change location
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'notifications'.tr,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Received notification"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text("Received newsletter"),
                  onChanged: null,
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Received Offer Notification"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Received App Updates"),
                  onChanged: null,
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                //log out
              },
            ),
          )
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
