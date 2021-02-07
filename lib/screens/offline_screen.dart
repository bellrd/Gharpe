import 'dart:io';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'main_screen/main_screen.dart';

class OfflineScreen extends StatelessWidget {
  final String error;

  OfflineScreen({@required this.error});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor.withOpacity(0.30),
              padding: EdgeInsets.fromLTRB(32, 32, 32, 8),
              height: size.height * 0.7,
              child: Image.asset(
                "assets/images/offline5.png",
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("You appears to be offline"),
                  Text(
                    "${this.error}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red[900]),
                  ),
                  RaisedButton(
                    color: kSecondaryColor,
                    elevation: 3,
                    onPressed: () async {
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          print("connected to internet");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        }
                      } on SocketException catch (_) {
                        print('Not connected');
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Network error"),
                          duration: Duration(milliseconds: 500),
                        ));
                      }
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
