import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:millchargesystem/view/credit/add_credit_page.dart';
import 'package:millchargesystem/view/credit/credit_info_page.dart';
import 'package:millchargesystem/view/debit/add_debit_page.dart';
import 'package:millchargesystem/view/notes/add_note_page.dart';
import 'package:millchargesystem/view/welcome_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
void main() {
  // runApp( MyApp());
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
          title: 'Mill Charge System',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WelcomeScreen(),
          routes: {
            "/add_credit_page" :(context) => AddCreditPage(),
            "/add_debit_page" :(context) =>AddDebitPage(),
            "/add_note_page" :(context) => AddNotePage(),
            "/credit_info_page" :(context)=>CreditInfoPage(),
          },
        ));
  }
}
