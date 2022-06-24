import 'package:cached_network_image/cached_network_image.dart';
import 'package:expendable_fab/expendable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:get/get.dart';
import 'package:millchargesystem/controllers/credit_tranaction_controller.dart';
import 'package:millchargesystem/controllers/generalinfocontroller/general_controller.dart';
import 'package:millchargesystem/controllers/logincontroller/logincontrollers.dart';
import 'package:millchargesystem/controllers/notecontroller/note_controller.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/utils/color_utill.dart';
import 'package:millchargesystem/utils/dialog_utils.dart';
import 'package:millchargesystem/utils/user_info_utils.dart';
import 'package:millchargesystem/view/drawer/main_drawer.dart';
import 'package:skeletons/skeletons.dart';

import '../../const_files.dart';

class DashBoardHomePage extends StatefulWidget {
  @override
  _DashBoardHomePageState createState() => _DashBoardHomePageState();
}

class _DashBoardHomePageState extends State<DashBoardHomePage> {
  ColorUtil colorUtil = ColorUtil();
  UserInfoUtills userInfoUtills = UserInfoUtills();
  UserInfoModel userInfoModel = UserInfoModel();
  DialogUtils dialogUtils = DialogUtils();
  final LoginController loginController = Get.put(LoginController());
  final GeneralController generalController = Get.put(GeneralController());
  final CreditTransactionController creditTransactionController =
      Get.put(CreditTransactionController());

  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                    color: Color(colorUtil.hexColor(APPBAR_COLOR))),
                toolbarHeight: .25.sh,
                backgroundColor: Color(colorUtil.hexColor(APPBAR_COLOR)),
                leading: new Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
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
              drawer: MainDrawer(),
              floatingActionButton: ExpendableFab(
                children: [
                  FloatingActionButton.small(
                    child: Container(
                        padding: EdgeInsets.only(left: 8),
                        width: 1.sw,
                        child: const Text(
                          "add credit",
                          style: TextStyle(fontSize: 8),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_credit_page");
                    },
                  ),
                  FloatingActionButton.small(
                    child: Container(
                        padding: EdgeInsets.only(left: 8),
                        width: 1.sw,
                        child: const Text(
                          "Add Debit",
                          style: TextStyle(fontSize: 8),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_debit_page");
                    },
                  ),
                  FloatingActionButton.small(
                    child: Container(
                        padding: EdgeInsets.only(left: 8),
                        width: 1.sw,
                        child: const Text(
                          "Add Mill",
                          style: TextStyle(fontSize: 8),
                        )),
                    onPressed: () {},
                  ),
                  FloatingActionButton.small(
                    child: Container(
                        padding: EdgeInsets.only(left: 8),
                        width: 1.sw,
                        child: const Text(
                          "Add Notes",
                          style: TextStyle(fontSize: 8),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_note_page");
                    },
                  ),
                ],
              ),
              body: Container(
                height: 1.sh,
                width: 1.sw,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //           "assets/gradiant13.png",
                //         ),
                //         fit: BoxFit.fill)),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 15, top: 10),
                      child: Container(
                        height: 0.17.sh,
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              elevation: 18.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/gradiant5png.png",
                                        ),
                                        fit: BoxFit.fill)),
                                height: 0.2.sh,
                                width: 0.42.sw,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 0.065.sh,
                                      width: 1.sw,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(0.01.sw),
                                            child: Container(
                                              child: Image.asset(
                                                  "assets/millcharge.png"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 0.2.sw,
                                            child: Text(
                                              "Current Mill Charge",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      return generalController
                                                  .isLoading.value ==
                                              false
                                          ? Container(
                                              height: 0.07.sh,
                                              width: 0.3.sw,
                                              child: Center(
                                                child: Text(
                                                  generalController
                                                              .localgeneralInfos[
                                                                  0]
                                                              .currentmillcharge
                                                              .toString()
                                                              .length >
                                                          6
                                                      ? generalController
                                                              .localgeneralInfos[
                                                                  0]
                                                              .currentmillcharge
                                                              .toString()
                                                              .substring(0, 5) +
                                                          " Taka"
                                                      : generalController
                                                          .localgeneralInfos[0]
                                                          .currentmillcharge
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : SizedBox();
                                    })
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 18,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Color(colorUtil.hexColor(BLUE_COLOR_800)),
                                ),
                                height: 0.2.sh,
                                width: 0.42.sw,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 0.065.sh,
                                      width: 1.sw,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(0.01.sw),
                                            child: Container(
                                              color: Colors.white,
                                              child: Image.asset(
                                                  "assets/cashinhand.png"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 0.2.sw,
                                            child: Text(
                                              "Cash In Hand",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Obx(() {
                                      return generalController
                                                  .isLoading.value ==
                                              false
                                          ? Container(
                                              height: 0.07.sh,
                                              width: 0.3.sw,
                                              child: Center(
                                                child: Text(
                                                  generalController
                                                              .localgeneralInfos[
                                                                  0]
                                                              .cashinhand
                                                              .toString()
                                                              .length >
                                                          5
                                                      ? generalController
                                                              .localgeneralInfos[
                                                                  0]
                                                              .cashinhand
                                                              .toString()
                                                              .substring(0, 5) +
                                                          " Taka"
                                                      : generalController
                                                              .localgeneralInfos[
                                                                  0]
                                                              .cashinhand
                                                              .toString() +
                                                          " Taka",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          : CircularProgressIndicator();
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 15, top: 10, bottom: 10),
                      child: Container(
                        height: 0.17.sh,
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(colorUtil
                                        .hexColor(THIS_MONTH_DEBIT_COST)),
                                  ),
                                  height: 0.2.sh,
                                  width: 0.42.sw,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 0.065.sh,
                                        width: 1.sw,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(0.01.sw),
                                              child: Container(
                                                child: Image.asset(
                                                    "assets/my_debit.png"),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 0.2.sw,
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 0.01.sh,
                                                ),
                                                Text(
                                                  "This Month Total Debits",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        return generalController.isLoading ==
                                                false
                                            ? Container(
                                                height: 0.07.sh,
                                                child: Center(
                                                  child: Text(
                                                    generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotaldebit
                                                                .toString()
                                                                .length >
                                                            6
                                                        ? generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotaldebit
                                                                .toString()
                                                                .substring(
                                                                    0, 5) +
                                                            " Taka"
                                                        : generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotaldebit
                                                                .toString() +
                                                            " Taka",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.grey,
                                                ),
                                              );
                                      }),
                                      // Container(
                                      //   height: 0.07.sh,
                                      //   child: Center(
                                      //     child: Text(
                                      //       "10.00 Taka",
                                      //       style: TextStyle(
                                      //           fontSize: 18.sp,
                                      //           color: Colors.white),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/credit_info_page");
                              },
                              child: Card(
                                elevation: 18,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/gradiant10.png",
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  height: 0.2.sh,
                                  width: 0.42.sw,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 0.065.sh,
                                        width: 1.sw,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(0.01.sw),
                                              child: Container(
                                                child: Image.asset(
                                                    "assets/addcredit.png"),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 0.2.sw,
                                              child: Text(
                                                "This Month Total Credit",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Obx(() {
                                        return generalController.isLoading ==
                                                false
                                            ? Container(
                                                height: 0.07.sh,
                                                child: Center(
                                                  child: Text(
                                                    generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotalcredit
                                                                .toString()
                                                                .length >
                                                            6
                                                        ? generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotalcredit
                                                                .toString()
                                                                .substring(
                                                                    0, 5) +
                                                            " Taka"
                                                        : generalController
                                                                .localgeneralInfos
                                                                .value[0]
                                                                .monthtotalcredit
                                                                .toString() +
                                                            " Taka",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.grey,
                                                ),
                                              );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 0.3.sh,
                        width: 1.sw,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 0.5.sw,
                              child: Card(
                                elevation: 18,
                                shadowColor: Colors.grey,
                                color: Color(colorUtil.hexColor("#e6ba3f")),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                                height: 0.05.sh,
                                                width: 0.1.sw,
                                                child: Image.asset(
                                                  "assets/notes_taking.png",
                                                  fit: BoxFit.cover,
                                                ))),
                                        SizedBox(
                                          width: 0.02.sw,
                                        ),
                                        Container(
                                          child: Text(
                                            "Important Notes",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    Obx(() {
                                      return noteController
                                                  .isLoadingNotes.value ==
                                              false
                                          ? Container(
                                              height: 0.2.sh,
                                              width: 1.sw,
                                              child: ListView.builder(
                                                  itemCount: noteController
                                                      .singleNoteList
                                                      .value
                                                      .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: <Widget>[
                                                        index == 0
                                                            ? Divider(
                                                                color:
                                                                    Colors.grey,
                                                                thickness: 0.5,
                                                              )
                                                            : SizedBox(
                                                                height: 0.sh,
                                                              ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        0.02.sw,
                                                                    right: 0.02
                                                                        .sw),
                                                            child: Container(
                                                              width: 1.sw,
                                                              child: Text(noteController
                                                                  .singleNoteList
                                                                  .value[index]
                                                                  .noticeDescription),
                                                            )),
                                                        Divider(
                                                          color: Colors.grey,
                                                          thickness: 0.5,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            )
                                          : Container(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                    }),
                                    SizedBox(
                                      height: 0.01.sh,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0.03.sw,
                            ),
                            Column(
                              children: [
                                new InkWell(
                                  onTap: () => print('hello'),
                                  // child: new Container(
                                  //   //width: 100.0,
                                  //   width: 0.4.sw,
                                  //   height: 0.04.sh,
                                  //   decoration: new BoxDecoration(
                                  //     color: Color(colorUtil.hexColor(LIGHT_RED_700)),
                                  //     border: new Border.all(color: Colors.black, width: 2.0),
                                  //     borderRadius: new BorderRadius.circular(10.0),
                                  //   ),
                                  //   child: new Center(child: new Text('Add Notes', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                                  // ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.02.sh),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(colorUtil
                                                .hexColor(ASH_COLOR_400)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2.0,
                                                spreadRadius: 0.0,
                                                offset: Offset(3.0,
                                                    3.0), // shadow direction: bottom right
                                              )
                                            ],
                                          ),
                                          height: 0.12.sh,
                                          width: 0.4.sw,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 0.06.sh,
                                                width: 1.sw,
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          0.01.sw),
                                                      child: Container(
                                                        child: Image.asset(
                                                            "assets/cashback.jpg"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 0.2.sw,
                                                      child: Column(children: [
                                                        SizedBox(
                                                          height: 0.01.sh,
                                                        ),
                                                        Text(
                                                          "Cash Back",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Obx(() {
                                                return generalController
                                                            .isLoading ==
                                                        false
                                                    ? Container(
                                                        height: 0.04.sh,
                                                        child: Center(
                                                          child: Text(
                                                            generalController
                                                                        .localgeneralInfos
                                                                        .value[
                                                                            0]
                                                                        .back
                                                                        .toString()
                                                                        .length >
                                                                    6
                                                                ? generalController
                                                                        .localgeneralInfos
                                                                        .value[
                                                                            0]
                                                                        .back
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            5) +
                                                                    " Taka"
                                                                : generalController
                                                                        .localgeneralInfos
                                                                        .value[
                                                                            0]
                                                                        .back
                                                                        .toString() +
                                                                    " Taka",
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.02.sh,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(colorUtil
                                              .hexColor(ASH_COLOR_700)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(3.0,
                                                  3.0), // shadow direction: bottom right
                                            )
                                          ],
                                        ),
                                        height: 0.12.sh,
                                        width: 0.4.sw,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 0.06.sh,
                                              width: 1.sw,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(0.01.sw),
                                                    child: Container(
                                                      child: Image.asset(
                                                          "assets/willpay.jpg"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 0.2.sw,
                                                    child: Column(children: [
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Text(
                                                        "Have To Paid",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ]),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Obx(() {
                                              return generalController
                                                          .isLoading ==
                                                      false
                                                  ? Container(
                                                      height: 0.04.sh,
                                                      child: Center(
                                                        child: Text(
                                                          generalController
                                                                      .localgeneralInfos
                                                                      .value[0]
                                                                      .addmore
                                                                      .toString()
                                                                      .length >
                                                                  6
                                                              ? generalController
                                                                      .localgeneralInfos
                                                                      .value[0]
                                                                      .addmore
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          5) +
                                                                  " Taka"
                                                              : generalController
                                                                      .localgeneralInfos
                                                                      .value[0]
                                                                      .addmore
                                                                      .toString() +
                                                                  " Taka",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                            }),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          height: 0.15.sh,
                          width: 1.sw,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 0.4.sw,
                                height: 0.1.sh,
                                child: Image.asset(
                                  "assets/all_credit.jpg",
                                  height: 0.06.sh,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 40),
                                width: 0.4.sw,
                                height: 0.1.sh,
                                child: Column(children: [
                                  Text(
                                    "Transactions ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "We like to provide you all sectors of transactions",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //start of credit transactions widgets

                    Obx(() {
                      return creditTransactionController.isLoadingCredit ==
                              false
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 0.94.sw,
                                height: 0.29.sh,
                                child: Row(
                                  children: [
                                    //start of transaction of credit cards
                                    Container(
                                      width: 0.62.sw,
                                      height: 0.267.sh,
                                      child: ListView.builder(
                                          itemCount: creditTransactionController
                                              .localCreditInfos.value.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 0.62.sw,
                                                      height: 0.13.sh,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 0.62.sw,
                                                            height: 0.13.sh,
                                                            child: InkWell(
                                                              onTap: () {
                                                                dialogUtils.showDebitTransactionDetails(creditTransactionController
                                                                    .localCreditInfos.value[index],context,"homepage");
                                                              },
                                                              child: Card(
                                                                elevation: 18,
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        width: 0.02
                                                                            .sw,
                                                                      ),
                                                                      new CachedNetworkImage(
                                                                        imageBuilder:
                                                                            (context, imageProvider) =>
                                                                                Container(
                                                                          width:
                                                                              30.0,
                                                                          height:
                                                                              30.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        progressIndicatorBuilder: (context,
                                                                                url,
                                                                                progress) =>
                                                                            Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            value:
                                                                                progress.progress,
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                        imageUrl:
                                                                            "https://millcharge.xixotech.net/public/uploads/" +
                                                                                creditTransactionController.localCreditInfos.value[index].creditImage,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 0.02
                                                                            .sw,
                                                                      ),
                                                                      Column(
                                                                        children: <
                                                                            Widget>[
                                                                          SizedBox(
                                                                            height:
                                                                                0.015.sh,
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(left: 0.03.sw),
                                                                              child: Container(
                                                                                  width: 0.35.sw,
                                                                                  child: Text(
                                                                                    "Date : " + creditTransactionController.localCreditInfos.value[index].creditDate,
                                                                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                                                  ))),
                                                                          SizedBox(
                                                                            height:
                                                                                0.01.sh,
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(left: 0.03.sw),
                                                                              child: Container(
                                                                                  width: 0.35.sw,
                                                                                  child: Text(
                                                                                    creditTransactionController.localCreditInfos.value[index].creditDescription,
                                                                                    maxLines: 3,
                                                                                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                                                                                  ))),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            );
                                          }),
                                    ),
                                    //end of transaction of credit cards
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          right: 0,
                                          top: 10,
                                          bottom: 10),
                                      child: Container(
                                        height: 0.24.sh,
                                        width: 0.3.sw,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Card(
                                              elevation: 18,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      colorUtil.hexColor(
                                                          MY_DEBIT_COLOR)),
                                                ),
                                                height: 0.2.sh,
                                                width: 0.276.sw,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 0.1.sh,
                                                      width: 1.sw,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.01.sw),
                                                            child: Container(
                                                              height: 1.sh,
                                                              width: 0.12.sw,
                                                              child: Image.asset(
                                                                  "assets/my_debit.png"),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 0.12.sw,
                                                            height: 0.3.sh,
                                                            child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        0.03.sh,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "My Total Credit",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 11
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Obx(() {
                                                      return generalController
                                                                  .isLoading ==
                                                              false
                                                          ? Container(
                                                              height: 0.07.sh,
                                                              child: Center(
                                                                child: Text(
                                                                  generalController.localgeneralInfos.value[0].mytotalcredit
                                                                              .toString()
                                                                              .length >
                                                                          6
                                                                      ? generalController
                                                                              .localgeneralInfos
                                                                              .value[
                                                                                  0]
                                                                              .mytotalcredit
                                                                              .toString()
                                                                              .substring(0,
                                                                                  5) +
                                                                          " Taka"
                                                                      : generalController
                                                                              .localgeneralInfos
                                                                              .value[0]
                                                                              .mytotalcredit
                                                                              .toString() +
                                                                          " Taka",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            )
                                                          : Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 2,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: false,
                                    width: 1.sw,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength:
                                        MediaQuery.of(context).size.width / 2,
                                  )),
                            );
                    })

                    //end of credit transactions widgets
                  ],
                ),
              ),
            ));
  }

  @override
  void initState() {
    getUserInfo();
    getGeneralInfo();
    getCreditTransactions();
    getCurrentMonthNotes();
  }

  Future<void> getUserInfo() async {
    userInfoModel = await userInfoUtills.getUserDetailsInfo();
  }

  Future<void> getGeneralInfo() async {
    final GeneralController generalController = Get.put(GeneralController());
    await generalController.getAllGeneralInfo();
  }

  Future<void> getCreditTransactions() async {
    final CreditTransactionController creditTransactionController =
        Get.put(CreditTransactionController());
    await creditTransactionController.getRecentCreditTransactions();
  }

  Future<void> getCurrentMonthNotes() async {
    final NoteController noteController = Get.put(NoteController());
    noteController.getNotes("yes", "");
  }

  void showDebitTransactionDetails(int index, BuildContext context) {}
}
