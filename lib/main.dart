import 'package:finance_app/HomePage/homepage.dart';
import 'package:finance_app/Insurance/InsuranceHomePage.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:finance_app/advisor.dart';
import 'package:finance_app/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserProfile.dart';
import 'package:finance_app/Refer.dart';
import 'package:flutter/services.dart';
import 'menu_page.dart';
import 'SignUP_PageWith_Chnages/signup2.dart';
import 'forget_password.dart';
import 'NotificationPage.dart';
import 'mPinPage.dart';
import 'package:finance_app/Fingerprint.dart';
import 'package:finance_app/Investments/InvestmentHomePage.dart';
import 'package:finance_app/Investments/InvestmentPacks.dart';
import 'package:finance_app/Investments/InvestmentPackDetails.dart';
import 'package:finance_app/Investments/PacksInfo.dart';
import 'MyGoals/GoalsHomePage.dart';

// TESTING COMMENT

//TESTING COMMENT 2
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
    home: email == null
        ? LoginPage()
        : HomePage(
            currentUserID: '987654321',
          ),
  ));
}
