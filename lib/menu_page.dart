import 'package:finance_app/Income_Expenses/income2.dart';
import 'package:finance_app/MyGoals/NewGoalsHomePage.dart';
import 'package:finance_app/NewsLetter/NewsLetter.dart';
import 'package:finance_app/Reward.dart';
import 'package:finance_app/newRefer.dart';
import 'package:finance_app/newadvisor.dart';
import 'package:finance_app/SignUP_PageWith_Chnages/Working_signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Support/Support.dart';
import 'Learning/LearningHomePage.dart';
import 'components/dual_button_tiles.dart';
import 'package:finance_app/UserProfile.dart';
import 'contact_us.dart';
import 'package:finance_app/Investments/InvestmentHomePage.dart';
import 'Insurance/InsuranceHomePage.dart';

class menuPage extends StatefulWidget {
  String currentUserID;
  menuPage({@required this.currentUserID});
  @override
  _menuPageState createState() => _menuPageState(currentUserID: currentUserID);
}

class _menuPageState extends State<menuPage> {
  String currentUserID;
  _menuPageState({@required this.currentUserID});
  String userName = 'Akhilesh';
  @override
  Widget build(BuildContext context) {
    double tileWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: ListView(
          children: <Widget>[
            Container(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff63E2E0),
                ),
                child: Text(
                  '$userName',
                  style: TextStyle(
                    color: Color(0xff373D3F),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ProfileButtons(
                title: 'Profile',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => UserProfile(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.person_outline),
            ProfileButtons(
                title: 'Holdings',
                onPress: () {},
                width: tileWidth,
                icon: Icons.business_center),
            ProfileButtons(
                title: 'Investment',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => InvestmentHomePage(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.attach_money),
            ProfileButtons(
                title: 'Insurance',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => InsuranceHomePage(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.home),
            ProfileButtons(
                title: 'Statements',
                onPress: () {},
                width: tileWidth,
                icon: Icons.receipt),
            ProfileButtons(
                title: 'Learning',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LearningHomePage(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.trending_up),
            ProfileButtons(
                title: 'Income and Expense',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => income2(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.compare_arrows),
            ProfileButtons(
              title: "Goals",
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => NewGoalsPage(
                              currentUserID: currentUserID,
                            )));
              },
              width: tileWidth,
              icon: Icons.outlined_flag,
            ),
            ProfileButtons(
                title: 'Rewards & Referrals',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RewardPage(

                              )));
                },
                width: tileWidth,
                icon: Icons.card_giftcard),
            ProfileButtons(
                title: 'Advisor',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AdvisorPage(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.assistant),
            ProfileButtons(
                title: 'News Letter',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NewsLetter()));
                },
                width: tileWidth,
                icon: Icons.library_books),
            ProfileButtons(
                title: 'About Us',
                onPress: () {},
                width: tileWidth,
                icon: Icons.business),
            ProfileButtons(
                title: 'Help & Support',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Support(
                                currentUserID: currentUserID,
                              )));
                },
                width: tileWidth,
                icon: Icons.call),
            ProfileButtons(
                title: 'Sign Out',
                onPress: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                    (Route route) => false,
                  );
                },
                width: tileWidth,
                icon: Icons.exit_to_app),
          ],
        ),
      ),
    );
  }
}
