import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:get/get.dart';
import 'package:millchargesystem/const_files.dart';
import 'package:millchargesystem/controllers/logincontroller/logincontrollers.dart';
import 'package:millchargesystem/utils/color_utill.dart';
import 'package:millchargesystem/view/dashboard/dashboard_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ColorUtil colorUtil = ColorUtil();
  TextEditingController emailTextEditor = TextEditingController();
  TextEditingController passwordTextEditor = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                    color: Color(colorUtil.hexColor(APPBAR_COLOR))),
                backgroundColor: Color(colorUtil.hexColor(APPBAR_COLOR)),
                title: Text("User Login"),
              ),
              body: Stack(
                children: [
                  Container(
                    height: 1.sh,
                    width: 1.sh,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: .05.sh,
                        ),
                        Container(
                          width: .4.sw,
                          height: .03.sh,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "User",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: .025.sw,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              )
                            ],
                          ),
                        ),

                        //start of email
                        SizedBox(
                          height: 0.03.sh,
                        ),
                        Container(
                            width: .9.sw,
                            child: Text(
                              "Email",
                              style: TextStyle(fontSize: 15.sp),
                            )),
                        SizedBox(
                          height: 0.015.sh,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.04.sw),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                height: .05.sh,
                                width: .6.sw,
                                child: TextFormField(
                                  controller: emailTextEditor,
                                  // controller: icEditTextController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter your Email",
                                    hintStyle: TextStyle(fontSize: 12.sp),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(colorUtil
                                                .hexColor("#eeeeee")))),
                                  ),
                                )),
                          ),
                        ),
                        //end of email

                        //start of password
                        SizedBox(
                          height: 0.03.sh,
                        ),
                        Container(
                            width: .9.sw,
                            child: Text(
                              "Password",
                              style: TextStyle(fontSize: 15.sp),
                            )),
                        SizedBox(
                          height: 0.015.sh,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.04.sw),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                height: .05.sh,
                                width: .6.sw,
                                child: TextFormField(
                                  controller: passwordTextEditor,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(fontSize: 12.sp),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Color(colorUtil
                                                .hexColor("#eeeeee")))),
                                  ),
                                )),
                          ),
                        ),

                        //start of sign up btn
                        SizedBox(
                          height: 0.03.sh,
                        ),
                        InkWell(
                          onTap: () async {
                            var email = emailTextEditor.text;
                            var password = passwordTextEditor.text;
                            var result = await loginController.loginUser(
                                email, password, "1"); //for user email login
                            if (result) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  (DashBoardHomePage()),
                                ),
                              );
                            } else if (!result) {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      // title: Text(scammedList[_current].title),
                                      title: Text("Warning"),
                                      content: Container(
                                        height: 0.12.sh,
                                        child: Column(children: [
                                          Text(
                                              "Unauthorized. Failed to login , please try again later"),
                                          SizedBox(height: 0.01.sh,),
                                          RaisedButton(color: Colors.red,onPressed: (){
                                            Navigator.pop(context);
                                          },child: Text("Okay",style: TextStyle(color: Colors.white),),)
                                        ]),
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 0.04.sw),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  height: .05.sh,
                                  width: .6.sw,
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        //end of signup btn

                        SizedBox(
                          height: 0.015.sh,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.2.sw),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: .05.sh,
                              width: .6.sw,
                              child: Row(
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  SizedBox(
                                    width: .03.sw,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        // Navigator.pushNamed(context, "/loginpage");
                                      },
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0.16.sh,
                      right: 0.03.sw,
                      child: Container(
                        child: Image.asset(
                          "assets/login_page_icon.jpg",
                          height: 0.25.sh,
                          width: 0.3.sw,
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
            ));
  }
}
