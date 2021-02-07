import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constant.dart';

class Otp extends StatefulWidget {
  TextEditingController _controller;

  Otp({controller: TextEditingController}) {
    this._controller = controller;
  }

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with CodeAutoFill {
  String _code;

  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void codeUpdated() {
    try {
      setState(() {
        _code = code;
      });
    } catch (e) {
      print("handling bad errors;");
    }
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        kDefaultPadding,
        2 * kDefaultPadding,
        kDefaultPadding,
        kDefaultPadding,
      ),
      child: PinFieldAutoFill(
        controller: this.widget._controller,
        decoration: UnderlineDecoration(
          textStyle: TextStyle(fontSize: 20, color: Colors.black),
          colorBuilder: FixedColorBuilder(
            Colors.black.withOpacity(0.3),
          ),
        ),
        currentCode: _code,
      ),
    );
  }
}
