import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  Widget build(BuildContext context) {
    //TODO make links clickable

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontFamily: "ProductSans"),
        children: [
          TextSpan(
              text: "By continuing you agree to the ",
              style: TextStyle(color: Colors.black)),
          TextSpan(text: "terms ", style: TextStyle(color: Colors.blue)),
          TextSpan(text: "and ", style: TextStyle(color: Colors.black)),
          TextSpan(
              text: "privacy policy ", style: TextStyle(color: Colors.blue)),
          TextSpan(text: "of Gharpay ", style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
