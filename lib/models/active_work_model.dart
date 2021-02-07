import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

import '../constant.dart';
import 'service_model.dart';

class ActiveWorkStatus {
  int id;
  String status;
  String time;

  ActiveWorkStatus({this.id, this.status, this.time});

  factory ActiveWorkStatus.fromJson(Map<String, dynamic> json) {
    return ActiveWorkStatus(
        id: json['id'], status: json['status'], time: json['time']);
  }
}

class ActiveWork {
  int id;
  String workerName;
  String description;
  String currentStatus;
  String address;
  String paymentMode;
  String paymentStatus;
  DateTime datetime;
  Service service;
  List<ActiveWorkStatus> statuses;

  ActiveWork(
      {this.id,
      this.service,
      this.workerName,
      this.description,
      this.currentStatus,
      this.address,
      this.paymentMode,
      this.paymentStatus,
      this.statuses,
      this.datetime});

  factory ActiveWork.fromJson(Map<String, dynamic> json) {
    List<dynamic> statusesJson = json['statuses'];

    List<ActiveWorkStatus> activeWorkStatusList =
        statusesJson.map((e) => ActiveWorkStatus.fromJson(e)).toList();

    return ActiveWork(
      id: json['id'],
      service: Service.fromJson(json['service']),
      workerName: json['worker_name'],
      description: json['description'],
      currentStatus: json['current_status'],
      address: json['address'],
      paymentMode: json['payment_mode'],
      paymentStatus: json['payment_status'],
      statuses: activeWorkStatusList,
    );
  }

  String calculateMinute() {
    return "150";
  }
}

class ActiveWorkList {
  final List<ActiveWork> activeWorks;

  ActiveWorkList({this.activeWorks});

  factory ActiveWorkList.fromJson(List<dynamic> json) {
    List<ActiveWork> activeWorkList = List<ActiveWork>();
    activeWorkList = json.map((e) => ActiveWork.fromJson((e))).toList();

    return ActiveWorkList(activeWorks: activeWorkList);
  }
}

Future<ActiveWorkList> getActiveWorkList() async {
  var response = await http.get(
    "$baseUrl/active-work/",
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token b64817becdaa4e98a72d33e3c91c5e90ae78caa6',
    },
  );

  if (response.statusCode == 200) {
    return ActiveWorkList.fromJson(jsonDecode(response.body));
  }
}
