import 'package:flutter/material.dart';
import 'package:millchargesystem/view/login/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/dashboard_home_page.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLogin;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // body: WelcomeBody(),
      body: Container() ,
    );
  }

  @override
  void initState() {
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("isLogin") != null) {
      if (preferences.getBool("isLogin") == true) {
        isLogin = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
            (DashBoardHomePage()),
          ),
        );

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => DashBoardHomePage()),
        //         (Route<dynamic> route) => false);
      }
      else{
        isLogin == false;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) =>
        //     (SpalshPage()),
        //   ),
        // );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false);

      }
    }
    else{
      isLogin = false;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //     (SpalshPage()),
      //   ),
      // );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
    }
  }
}