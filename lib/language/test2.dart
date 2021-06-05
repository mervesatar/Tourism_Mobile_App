import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/MainPage.dart';
import 'package:project/Settings/settings.dart';
import 'package:project/language/localization_service.dart';

import '../TripPage.dart';

class Test2 extends StatefulWidget {
  const Test2({Key key}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  String lng = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('change_language'.tr),
      ),
      body: Center(
        child: _uiWidget(),
      ),
    );
  }

  Widget _uiWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('hello_title'.tr),
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'language'.tr,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(width: 20.0),
            new DropdownButton<String>(
              items: LocalizationService.langs.map(
                (String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                },
              ).toList(),
              value: this.lng,
              underline: Container(
                color: Colors.tealAccent,
              ),
              isExpanded: false,
              onChanged: (newVal) {
                setState(() {
                  this.lng = newVal;
                  LocalizationService().changeLocale(newVal);
                });
              },
            ),
          ],
        ),
        InkWell(
          child: Center(
              child: Container(
                  height: 40.0,
                  width: 75.0,
                  color: Colors.blue,
                  child: Center(child: Text('ok'.tr)))),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (conrext) => MainPage()));
          },
        ),
      ],
    );
  }
}
