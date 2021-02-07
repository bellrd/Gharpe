import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';

class UpdateScreen extends StatelessWidget {
  final String version;

  UpdateScreen({@required this.version});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: kPrimaryColor.withOpacity(0.30),
              padding: EdgeInsets.fromLTRB(32, 32, 32, 8),
              height: size.height * 0.7,
              child: SvgPicture.asset(
                "assets/images/update_edit.svg",
              ),
            ),
            Container(
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("A new version is available"),
                  Text(
                    "${this.version}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RaisedButton.icon(
                    color: kSecondaryColor,
                    elevation: 0,
                    onPressed: () async {
                      //TODO Redirect to playstore
                      launch("https://gharpay.xyz/update");
                    },
                    icon: Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Update",
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
