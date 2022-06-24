import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:millchargesystem/controllers/credit_tranaction_controller.dart';
import 'package:millchargesystem/controllers/generalinfocontroller/general_controller.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/utils/color_utill.dart';
import 'package:millchargesystem/utils/common_util.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const_files.dart';

class AddDebitPage extends StatefulWidget {


  @override
  _AddDebitPageState createState() => _AddDebitPageState();
}

class _AddDebitPageState extends State<AddDebitPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CommonUtil _commonUtil = CommonUtil();
  ColorUtil colorUtil = ColorUtil();
  var creditDate;
  var creditYear;
  CalendarFormat format = CalendarFormat.month;
  File _selectedFile = null;
  final CreditTransactionController creditTransactionController =
  Get.put(CreditTransactionController());
  final GeneralController generalController = Get.put(GeneralController());
  ApiService _apiService = ApiService();
  String creditMonth;

  String creditDay;

  String creditDescription;

  String creditAmount;

  String creditShortNote;
  TextEditingController creditDateTextEditor = TextEditingController();
  TextEditingController creditDescriptionTextEditor = TextEditingController();
  TextEditingController creditAmountTextEditor = TextEditingController();
  TextEditingController creditShortNoteTextEditor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        appBar: AppBar(
          iconTheme:
          IconThemeData(color: Color(colorUtil.hexColor(APPBAR_COLOR))),
          toolbarHeight: .25.sh,
          backgroundColor: Color(colorUtil.hexColor(APPBAR_COLOR)),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              )),
          title: Row(children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    "My Dashboard",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                // userInfoModel.userinfo.name !=null?Text(userInfoModel.userinfo.name):Text("sdf")
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: .08.sw),
                child: Container(
                    width: 0.4.sw,
                    height: 0.16.sh,
                    color: Colors.white,
                    child: Image.asset("assets/dashboard.jpg")))
          ]),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 0.03.sh,
            ),
            Container(
                padding: EdgeInsets.only(left: 0.05.sw),
                width: .9.sw,
                child: Text(
                  "Debit Date",
                  style:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 0.015.sh,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.04.sw),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.only(left: 0.01.sw, right: 0.01.sw),
                    height: .05.sh,
                    width: 1.sw,
                    child: InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            theme: DatePickerTheme(
                                headerColor: Colors.orange,
                                backgroundColor: Colors.blue,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            minTime: DateTime(2018, 1, 5),
                            maxTime: DateTime(2050, 12, 7), onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              setState(() {
                                creditDate = date;
                              });
                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: TextField(
                        controller: creditDateTextEditor,

                        // controller: icEditTextController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          enabled: false,
                          fillColor: Colors.white,
                          hintText: creditDate.toString().length > 10
                              ? creditDate.toString().substring(0, 10)
                              : "Enter Credit Date",
                          hintStyle: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color(colorUtil.hexColor("#eeeeee")))),
                        ),
                      ),
                    )),
              ),
            ),
            //start of debit description
            SizedBox(
              height: 0.03.sh,
            ),
            Container(
                padding: EdgeInsets.only(left: 0.05.sw),
                width: .9.sw,
                child: Text(
                  "Debit Description",
                  style:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 0.015.sh,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.04.sw),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 0.01.sw, right: 0.01.sw),
                  height: 0.15.sh,
                  width: 1.sw,
                  child: TextField(
                    // controller: creditDescriptionTextEditor,
                    maxLines: 3,
                    onChanged: (text) {
                      creditDescription = text;
                    },
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 0.055.sw),
                width: .9.sw,
                child: Text(
                  "Debit Amount",
                  style:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 0.015.sh,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.04.sw),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 0.01.sw, right: 0.01.sw),
                  height: .05.sh,
                  width: 1.sw,
                  child: TextField(
                    onChanged: (text) {
                      creditAmount = text;
                    },
                    // controller: creditAmountTextEditor,
                    // controller: icEditTextController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter Credit Amount",
                      hintStyle: TextStyle(fontSize: 12.sp),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color(colorUtil.hexColor("#eeeeee")))),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 0.03.sh,
            ),
            Container(
                padding: EdgeInsets.only(left: 0.055.sw),
                width: .9.sw,
                child: Text(
                  "Debit Short Notes",
                  style:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 0.015.sh,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.04.sw, right: 0.04.sw),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 0.01.sw, right: 0.01.sw),
                  height: .05.sh,
                  width: 1.sw,
                  child: TextFormField(
                    onChanged: (text) {
                      creditShortNote = text;
                    },
                    // controller: creditShortNoteTextEditor,
                    // controller: icEditTextController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter Short Notes (optional)",
                      hintStyle: TextStyle(fontSize: 12.sp),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color(colorUtil.hexColor("#eeeeee")))),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.015.sh,
            ),

            Padding(
              padding: EdgeInsets.only(left: 0.05.sw, right: 0.04.sw),
              child: Text(
                "Upload photo :",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),

            _selectedFile == null
                ? Container(
              height: 120,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          // title: Text(scammedList[_current].title),
                          content: Container(
                            color: Colors.tealAccent,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Wrap(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          takeFromCameras(
                                              ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.camera_alt),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("From Camera")
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          takeFromCameras(
                                              ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons
                                                .phone_android_outlined),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("From Gallery")
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 70,
                ),
              ),
            )
                : InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        // title: Text(scammedList[_current].title),
                        content: Container(
                          color: Colors.tealAccent,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Wrap(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        takeFromCameras(
                                            ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.camera_alt),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("From Camera")
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        takeFromCameras(
                                            ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons
                                              .phone_android_outlined),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("From Gallery")
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Image.file(
                  _selectedFile,
                  height: 120,
                  width: 120,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Colors.red,
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
                onPressed: () {
                  print("credit date is ${creditDate}");

                  creditYear = _commonUtil.getYear(creditDate.toString());
                  creditMonth = _commonUtil.getMonth(creditDate.toString());
                  creditDay = _commonUtil.getDate(creditDate.toString());
                  print("credit day is ${creditDay}");
                  print("credit month is ${creditMonth}");
                  print("credit year is ${creditYear}");
                  print(
                      "credit information : ${creditDescription} ${creditShortNote} ${creditAmount}");
                  handleCreditInformation(
                      creditYear,
                      creditMonth,
                      creditDay,
                      creditDescription,
                      creditAmount,
                      creditShortNote,
                      creditDate.toString());
                  setState(() {
                    creditDescription = "";
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void takeFromCameras(ImageSource source) async {
    PickedFile image = await ImagePicker.platform.pickImage(source: source);
    if (image != null) {
      // Directory directory =
      //     await getApplicationDocumentsDirectory(); // AppData folder path
      //
      // // main storage folders path,but only works on android as IOS is not currently supported.
      //
      // var path = directory.path;
      //
      // print("path is : ${path}");
      setState(() {
        _selectedFile = File(image.path);
      });

      // await _apiService.UploadPicture("babc", _selectedFile);
      // File savedImage =
      //     await _selectedFile.copy('${path}/${_selectedFile}');

      // await apiService.UploadPicture("babc", image);

    }
  }

  void handleCreditInformation(
      String creditYear,
      String creditMonth,
      String creditDay,
      String creditDescription,
      String creditAmount,
      String creditShortNote,
      String creditDate) async {
    var response = await creditTransactionController.addCredit(
        creditYear,
        creditMonth,
        creditDay,
        creditDescription,
        creditAmount,
        creditShortNote,
        creditDate,
        _selectedFile,
        "debit");
    if (response == true) {
      await generalController.getAllGeneralInfo();
      Navigator.pop(context);
    }
  }
}
