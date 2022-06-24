import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:millchargesystem/controllers/credit_tranaction_controller.dart';
import 'package:millchargesystem/utils/color_utill.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletons/skeletons.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const_files.dart';

class CreditInfoPage extends StatefulWidget {
  @override
  _CreditInfoPageState createState() => _CreditInfoPageState();
}

class _CreditInfoPageState extends State<CreditInfoPage> {
  CalendarController _controller;
  CalendarController _calendarController = CalendarController();
  DateTime _selectedDay;
  ColorUtil colorUtil = ColorUtil();
  final CreditTransactionController creditTransactionController =
      Get.put(CreditTransactionController());

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    creditTransactionController
        .setSelectedDate(DateTime.now().toString().substring(0, 10));
    // print("foucused Date is :"+_calendarController.focusedDay.toString());
  }

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
                          "Credit Informations",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      // userInfoModel.userinfo.name !=null?Text(userInfoModel.userinfo.name):Text("sdf")
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: .01.sw),
                      child: Container(
                          width: 0.4.sw,
                          height: 0.16.sh,
                          color: Colors.white,
                          child: Image.asset(
                              "assets/credit_information_details.jpg")))
                ]),
              ),
              body: Padding(
                padding: EdgeInsets.all(0.01.sh),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 0.5.sh,
                      width: 1.sw,
                      child: TableCalendar(
                        calendarController: _calendarController,
                        calendarStyle: CalendarStyle(
                          todayColor: Colors.teal,
                        ),
                        availableGestures: AvailableGestures.all,
                        onDaySelected: _onDaySelected,
                        headerVisible: true,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "People Already Credited This Month",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          Obx(() {
                            return creditTransactionController.ishide.value ==
                                    false
                                ? InkWell(
                                    onTap: () {
                                      creditTransactionController
                                          .setHideOrShow(true);
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_up_outlined,
                                      size: 35,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      creditTransactionController
                                          .setHideOrShow(false);
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_down,
                                      size: 35,
                                    ),
                                  );
                          })
                        ],
                      ),
                    ),
                    Obx(() {
                      return creditTransactionController.isLoadingCreditSum ==
                              false
                          ? Visibility(
                              visible:
                                  creditTransactionController.ishide.value &&
                                          creditTransactionController
                                                  .creditSumModel
                                                  .value
                                                  .data
                                                  .length >
                                              0
                                      ? true
                                      : false,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 0.04.sw,
                                      right: 0.04.sw,
                                      top: 0.01.sh),
                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Name',
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Total Credit(In Taka)',
                                        ),
                                      ),
                                    ],
                                    rows: creditTransactionController
                                        .creditSumModel.value.data
                                        .map(
                                          (data) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(data.name)),
                                              DataCell(Text(data.totalCredit)),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  )),
                            )
                          : Container(
                              child: SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 3,
                                    spacing: 6,
                                    lineStyle: SkeletonLineStyle(
                                      randomLength: false,
                                      width: 1.sw,
                                      height: 0.08.sh,
                                      borderRadius: BorderRadius.circular(8),
                                      minLength:
                                          MediaQuery.of(context).size.width / 2,
                                    )),
                              ),
                            );
                    }),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0.07.sw),
                      child: Text(
                        "Searched Date Credits Transactions :",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(() {
                      return creditTransactionController
                                  .issingleDayGetCreditSumModelLoading.value ==
                              false
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 0.05.sw, right: 0.05.sw, top: 0.01.sh),
                              child: creditTransactionController
                                          .singleDayGetCreditSumModel
                                          .value
                                          .data
                                          .length >
                                      0
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: creditTransactionController
                                          .singleDayGetCreditSumModel
                                          .value
                                          .data
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Card(
                                                elevation: 15,
                                                child: Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0.03.sw,
                                                                  right:
                                                                      0.03.sw),
                                                          width: 1.sw,
                                                          child: Text(
                                                            "Credit Deposite Date :" +
                                                                creditTransactionController
                                                                    .singleDayGetCreditSumModel
                                                                    .value
                                                                    .data[index]
                                                                    .creditDate,
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          )),
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: <Widget>[
                                                            new CachedNetworkImage(
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                width: 20.0,
                                                                height: 20.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          progress) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: progress
                                                                      .progress,
                                                                ),
                                                              ),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                              imageUrl: "https://millcharge.xixotech.net/public/uploads/" +
                                                                  creditTransactionController
                                                                      .singleDayGetCreditSumModel
                                                                      .value
                                                                      .data[
                                                                          index]
                                                                      .creditImage,
                                                              fit: BoxFit.cover,
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                            Container(
                                                              width: 0.6.sw,
                                                              child:
                                                              ReadMoreText(
                                                                creditTransactionController.singleDayGetCreditSumModel.value.data[index].creditDescription,
                                                                style: TextStyle(color: Colors.black,fontSize: 13.sp),
                                                                trimLines: 2,
                                                                colorClickableText: Colors.pink,
                                                                trimMode: TrimMode.Line,
                                                                trimCollapsedText: 'Show more',
                                                                trimExpandedText: 'Show less',
                                                                moreStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                                              ),
                                                                  //expandablepanel
                                                              //     ExpandablePanel(
                                                              //   header: Text(
                                                              //     creditTransactionController.singleDayGetCreditSumModel.value.data[index].creditDescription,
                                                              //     maxLines: 2,
                                                              //       style: Theme.of(context).textTheme.bodyText2
                                                              //   ),
                                                              //   expanded: Align(
                                                              //       alignment:
                                                              //           Alignment
                                                              //               .centerLeft,
                                                              //       child: Text(
                                                              //         creditTransactionController.singleDayGetCreditSumModel.value.data[index].creditDescription,
                                                              //         softWrap:
                                                              //             true,
                                                              //       )),
                                                              // ),
                                                              //expandablepanel

                                                              // Text(
                                                              //   creditTransactionController
                                                              //       .singleDayGetCreditSumModel
                                                              //       .value
                                                              //       .data[index]
                                                              //       .creditDescription,
                                                              //   maxLines: 2,
                                                              //   overflow:
                                                              //       TextOverflow
                                                              //           .clip,
                                                              //   style:
                                                              //       TextStyle(
                                                              //     fontSize:
                                                              //         13.sp,
                                                              //   ),
                                                              // ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0.05.sw),
                                                        width: 0.9.sw,
                                                        child: Text(
                                                          "Short note : " +
                                                              creditTransactionController
                                                                  .singleDayGetCreditSumModel
                                                                  .value
                                                                  .data[index]
                                                                  .notes,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 0.02
                                                                        .sw),
                                                            child: Text("~" +
                                                                creditTransactionController
                                                                    .singleDayGetCreditSumModel
                                                                    .value
                                                                    .data[index]
                                                                    .name)),
                                                      ),
                                                      SizedBox(
                                                        height: 0.01.sh,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 0.01.sh,
                                            ),
                                          ],
                                        );
                                      })
                                  : Container(
                                      child: Column(
                                      children: <Widget>[
                                        Container(
                                            color: Colors.green,
                                            child: Image.asset(
                                              "assets/no_transaction.png",
                                              width: 0.5.sw,
                                              height: 0.22.sh,
                                              fit: BoxFit.fill,
                                            )),
                                        Center(
                                            child: Text(
                                          "No Transaction on this day",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                    )))
                          : Container(
                              child: SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 5,
                                    spacing: 6,
                                    lineStyle: SkeletonLineStyle(
                                      randomLength: false,
                                      width: 1.sw,
                                      height: 0.08.sh,
                                      borderRadius: BorderRadius.circular(8),
                                      minLength:
                                          MediaQuery.of(context).size.width / 2,
                                    )),
                              ),
                            );
                    })

                    // Container(
                    //   child: Obx(() {
                    //
                    //   }),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _onDaySelected(
      DateTime day, List<dynamic> events, List<dynamic> holidays) {
    creditTransactionController
        .setSelectedDate(day.toString().substring(0, 10));
  }
}
