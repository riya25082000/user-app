import 'package:finance_app/DisableTouchID.dart';
import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/ImageData.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:finance_app/Support/Support.dart';
import 'package:finance_app/Support/SupportSearch.dart';
import 'package:finance_app/TaxFiling.dart';
import 'package:finance_app/advisor.dart';
import 'package:finance_app/newadvisor.dart';
import 'package:finance_app/setPin.dart';
import 'package:finance_app/touchID.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mPinPage.dart';
import 'Tax-filling-page.dart';
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  runApp(
    MaterialApp(
      home: userid == null
          ? LoginPage()

          : Tax_flling_now(

              //currentUserID: userid,
            ),
    ),
  );
}
