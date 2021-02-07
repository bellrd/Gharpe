import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class AuthToken {
  final String accessToken;

  AuthToken({this.accessToken});

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(accessToken: json['accessToken']);
  }
}

class ServiceImage {
  final int id;
  final String tag;
  final String imageUrl;

  ServiceImage({this.id, this.tag, this.imageUrl});

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(
      id: json['id'],
      tag: json['tag'],
      imageUrl: json['image'],
    );
  }
}

class Service {
  final int id;
  final String name;
  final String description;
  final int baseCharge;
  final int minuteRate;
  final bool availability;
  final List<ServiceImage> serviceImages;
  final List<String> examples;

  Service({
    this.id,
    this.name,
    this.description,
    this.baseCharge,
    this.minuteRate,
    this.availability,
    this.serviceImages,
    this.examples,
  });

  String getIconUrl() {
    return serviceImages
        .firstWhere((element) => element.tag == "ICON")
        .imageUrl;
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    var examplesFromJson = json['examples'];
    List<dynamic> servicesImagesFromJson = json['images'];
    List<ServiceImage> serviceImages =
    servicesImagesFromJson.map((e) => ServiceImage.fromJson(e)).toList();

    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      baseCharge: json['base_charge'],
      minuteRate: json['minute_rate'],
      availability: json['availability'],
      serviceImages: serviceImages,
      examples: List<String>.from(examplesFromJson),
    );
  }
}

class ServiceList {
  final List<Service> services;

  ServiceList({this.services});

  Service serviceOfId(int id) {
    services.firstWhere((element) => element.id == id);
  }

  factory ServiceList.fromJson(List<dynamic> json) {
    List<Service> services = List<Service>();
    services = json.map((e) => Service.fromJson(e)).toList();
    return ServiceList(
      services: services,
    );
  }
}

Future<ServiceList> getServiceList() async {
  bool validCache = false;

  var pref = await SharedPreferences.getInstance();
  if (pref.containsKey("SERVICES_JSON_TIME")) {
    var fd = DateTime.parse(pref.getString("SERVICES_JSON_TIME"));
    var nd = DateTime.now();
    validCache = nd.difference(fd).inSeconds < 300 ? true : false;
  }

  if (validCache) {
    print("reading from cache");
    return ServiceList.fromJson(jsonDecode(pref.getString("SERVICES_JSON")));
  }

  print("fetching services from network");
  final response = await http.get("$baseUrl/service/");
  if (response.statusCode == 200) {
    pref.setString("SERVICES_JSON", response.body);
    pref.setString("SERVICES_JSON_TIME", DateTime.now().toString());
    return ServiceList.fromJson(jsonDecode(response.body));
  }
}
