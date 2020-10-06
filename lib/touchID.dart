















//
// import 'package:finance_app/HomePage.dart';
// import 'package:finance_app/HomePage/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:local_auth/local_auth.dart';
//
// class TouchScreen extends StatelessWidget {
//   final LocalAuthentication localAuth = LocalAuthentication();
//   String currentUserID;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () async {
//           bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;
//
//           if (weCanCheckBiometrics) {
//             bool authenticated = await localAuth.authenticateWithBiometrics(
//               localizedReason: "Authenticate to see your bank statement.",
//             );
//
//             if (authenticated) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => HomePage(currentUserID: '987654321'),
//                 ),
//               );
//             }
//           }
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Icon(
//               Icons.fingerprint,
//               size: 124.0,
//             ),
//             Text(
//               "Touch to Login",
//               style: GoogleFonts.passionOne(
//                 fontSize: 64.0,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
