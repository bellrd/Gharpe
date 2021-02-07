import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gharpay/models/service_model.dart';

class SearchBox extends StatelessWidget {
  List<Service> services;

  SearchBox({this.services});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      child: Container(
        width: size.width * 0.9,
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Search our services ?",
              hintStyle: TextStyle(fontSize: 15),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
              border: InputBorder.none,
              suffixIcon: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Icon(Icons.search, color: Colors.black),
              ),
            ),
          ),
          hideOnEmpty: true,
          suggestionsCallback: (pattern) async {
            var s = this.services.map((e) => e.name).toList();
            return s
                .where((element) =>
                    element.toUpperCase().contains(pattern.toUpperCase()))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
              visualDensity: VisualDensity.compact,
            );
          },
          onSuggestionSelected: (suggestion) {
            //TODO: navigator push
          },
        ),
      ),
    );
  }
}
