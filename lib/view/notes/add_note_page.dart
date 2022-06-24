import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:millchargesystem/controllers/credit_tranaction_controller.dart';
import 'package:millchargesystem/controllers/generalinfocontroller/general_controller.dart';
import 'package:millchargesystem/controllers/notecontroller/note_controller.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/utils/color_utill.dart';
import 'package:millchargesystem/utils/common_util.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const_files.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CommonUtil _commonUtil = CommonUtil();
  TextEditingController creditDateTextEditor = TextEditingController();
  var noteDate;
  var noteYear;
  CalendarFormat format = CalendarFormat.month;
  final CreditTransactionController creditTransactionController =
      Get.put(CreditTransactionController());
  final NoteController noteController =
      Get.put(NoteController());
  final GeneralController generalController = Get.put(GeneralController());
  ApiService _apiService = ApiService();

  String noteMonth;

  String noteDay;

  String noteDescription;

  String creditAmount;

  String creditShortNote;
  ColorUtil colorUtil = ColorUtil();

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
                  "Note Date",
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
                            noteDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: TextField(
                        controller: creditDateTextEditor,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          enabled: false,
                          fillColor: Colors.white,
                          hintText: noteDate.toString().length > 10
                              ? noteDate.toString().substring(0, 10)
                              : "Enter Note Date",
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
                  "Note Description",
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
                      noteDescription = text;
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
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("Adding Notes"),

                          content: Container(
                            height: 0.08.sh,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      });

                  print("credit date is ${noteDate}");
                  noteYear = _commonUtil.getYear(noteDate.toString());
                  noteMonth = _commonUtil.getMonth(noteDate.toString());
                  noteDay = _commonUtil.getDate(noteDate.toString());
                  print("credit day is ${noteDay}");
                  print("credit month is ${noteMonth}");
                  print("credit year is ${noteYear}");
                  print(
                      "credit information : ${noteDescription} ${creditShortNote} ${creditAmount}");
                  handleNoteInformation(noteYear, noteMonth, noteDay,
                      noteDescription, noteDate.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleNoteInformation(noteYear, String noteMonth, String noteDay,
      String noteDescription, String noteDate) async{

    var response = await noteController.addNotes(noteYear.toString(),noteMonth,noteDay,noteDescription,noteDate);
    if(response){
      noteController.getNotes("yes","");
      Navigator.pop(context);
      Navigator.pop(context);
    }

  }
}
