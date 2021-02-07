import 'package:flutter/material.dart';
import '../../../constant.dart';

class Mobile extends StatelessWidget {
  TextEditingController _controller;
  Mobile({controller: TextEditingController}) {
    _controller = controller;
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(kDefaultPadding, 2 * kDefaultPadding,
          kDefaultPadding, kDefaultPadding),
      child: TextField(
        controller: _controller,
        enableSuggestions: true,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Without country code",
          filled: true,
          labelText: "Mobile number",
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.black38,
          ),
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black26),
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
