import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppSlider {
  int id;
  String photo;
  String headline;
  String description;
  String link;

  AppSlider({this.id, this.photo, this.headline, this.description, this.link});

  factory AppSlider.fromJson(Map<String, dynamic> json) {
    return AppSlider(
      id: json['id'],
      photo: json['photo'],
      headline: json['headline'],
      description: json['description'],
      link: json['link'],
    );
  }
}

class AppSliderList {
  List<AppSlider> appSliders;

  AppSliderList({this.appSliders});

  factory AppSliderList.fromJson(List<dynamic> json) {
    return AppSliderList(
      appSliders: json.map((e) => AppSlider.fromJson(e)).toList(),
    );
  }
}

Future<AppSliderList> getAppSliderList() async {
  var pref = await SharedPreferences.getInstance();
  bool validCache = false;
  if (pref.containsKey("APP_SLIDERS_JSON_TIME")) {
    var fd = DateTime.parse(pref.getString("APP_SLIDERS_JSON_TIME"));
    var nd = DateTime.now();
    validCache = nd.difference(fd).inSeconds < 3000 ? true : false;
  }

  if (validCache) {
    print("app_slider : returning from cache");
    return AppSliderList.fromJson(
        jsonDecode(pref.getString("APP_SLIDERS_JSON")));
  }

  print("app_slider: fetching from network");
  final response = await http.get("https://gharpay.xyz/content/app-slider/");
  if (response.statusCode == 200) {
    pref.setString("APP_SLIDERS_JSON", response.body);
    pref.setString("APP_SLIDERS_JSON_TIME", DateTime.now().toString());
    // print(response.body);
    return AppSliderList.fromJson(jsonDecode(response.body));
  }
}
