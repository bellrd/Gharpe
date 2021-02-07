import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant.dart';

class Header extends StatelessWidget {
  String title;
  String subtitle;
  Function changeStep;

  Header({title: String, subtitle: String, Function changeStep}) {
    this.title = title;
    this.subtitle = subtitle;
    this.changeStep = changeStep;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.5),
      height: size.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 5.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back_rounded),
                  onTap: () {
                    if (this.title.toUpperCase().contains("PASSWORD"))
                      print("Already on mobile page");
                    else {
                      changeStep();
                    }
                  },
                ),
                FlatButton.icon(
                  onPressed: () {
                    launch("https://gharpay.xyz/support/");
                  },
                  icon: Icon(Icons.help_rounded),
                  label: Text("Support"),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title\n",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$subtitle",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ProductSans',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
