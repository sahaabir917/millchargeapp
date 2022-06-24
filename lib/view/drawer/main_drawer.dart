import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainDrawer extends StatefulWidget {


  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => Padding(
            padding: EdgeInsets.only(top: 30),
            child: Drawer(
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                        child: ListView(
                      children: <Widget>[
                        Text("Add Debit")
                      ],
                    ))))));
  }
}
