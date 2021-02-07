import 'dart:convert';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import 'components/header.dart';
import 'components/mobile.dart';
import 'components/notice.dart';
import 'components/otp.dart';

class LoginScreen extends StatefulWidget {
  String verificationId;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _step = 0;
  final mobileController = TextEditingController();
  final otpController = TextEditingController();
  bool loading = false;

  void changeStep() {
    setState(() {
      _step = _step == 0 ? 1 : 0;
      loading = false;
    });
  }

  void submitHandler() async {
    if (_step == 0) {
      if (mobileController.text.length != 10) {
        return;
      }

      setState(() {
        loading = true;
      });

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + mobileController.text,
          verificationCompleted: (PhoneAuthCredential pc) async {
            await FirebaseAuth.instance.signInWithCredential(pc);
          },
          verificationFailed: (e) {
            print("something went wrong please try again later");
            print(e.message);
          },
          codeSent: (verificationId, resendToken) {
            print("Code sent");
            this.widget.verificationId = verificationId;
            changeStep();
          },
          codeAutoRetrievalTimeout: (s) => print("code auto retrieve timeout"));
    } else {
      print("Manual verification");
      if (otpController.text.length != 6) {
        return;
      }
      setState(() {
        loading = true;
      });
      String otp = otpController.text;
      PhoneAuthCredential pc = PhoneAuthProvider.credential(
          verificationId: this.widget.verificationId, smsCode: otp);
      try {
        await FirebaseAuth.instance.signInWithCredential(pc);
      } catch (Exception) {
        print("Manual login error.");
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !loading
          ? FloatingActionButton.extended(
              label: Text(
                "VERIFY",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              icon: Icon(Icons.check, color: kPrimaryColor),
              backgroundColor: Colors.black87,
              onPressed: submitHandler,
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: CountdownTimer(
                endTime: DateTime.now().millisecondsSinceEpoch + 120000,
                onEnd: () {
                  if (this.mounted) {
                    setState(() {
                      loading = false;
                    });
                  }
                },
                widgetBuilder: (_, time) {
                  if (time == null) return Container();
                  // return Text(
                  //   "${time.min == null ? 0 : time.min} : ${time.sec.toString().padLeft(2, '0')}",
                  // );
                  return FloatingActionButton(
                    backgroundColor: Colors.black87,
                    onPressed: () {},
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white38,
                      valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                      strokeWidth: 3,
                    ),
                  );
                },
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Header(
                title: _step == 0
                    ? "Enter your mobile number"
                    : "Enter One time Password ",
                // this string must contain Password (word)
                subtitle: _step == 0
                    ? "You will receive an otp on your mobile number for verification purpose"
                    : "Enter 6-digit otp sent to your mobile number\n Do not share your otp",
                changeStep: changeStep,
              ),
            ),
            AnimatedSwitcher(
              child: _step == 0
                  ? Mobile(controller: mobileController)
                  : Otp(controller: otpController),
              duration: Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(scale: animation, child: child),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              width: double.infinity,
              child: Notice(),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> verifyUserOnServer(User user) async {
  var idToken = await user.getIdToken(true);
  var mobileNumber = user.phoneNumber.substring(3);
  http.Response response = await http.post(
    '$baseUrl/user/login_via_firebase/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'id_token': idToken, 'mobile_number': mobileNumber}),
  );

  if (response.statusCode == 200) {
    // var at = AuthToken.fromJson(jsonDecode(response.body));
    // var pref = locator<SharedPreferences>();
    // pref.setString("ACCESS_TOKEN", "token ${at.accessToken}");
    return true;
  }
  print(jsonDecode(response.body));
  return false;
}
