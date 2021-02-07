import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gharpay/models/active_work_model.dart';
import 'package:gharpay/screens/work_fragment/components/status_stepper.dart';

import '../../../constant.dart';

class ActiveWorkWidget extends StatefulWidget {
  final StreamController<ActiveWorkList> streamController;

  ActiveWorkWidget({this.streamController});

  @override
  _ActiveWorkWidgetState createState() => _ActiveWorkWidgetState();
}

class _ActiveWorkWidgetState extends State<ActiveWorkWidget> {
  @override
  void initState() {
    getActiveWorkList().then((value) => widget.streamController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.streamController.stream.asBroadcastStream(),
      builder: (context, AsyncSnapshot<ActiveWorkList> snapshot) {
        if (snapshot.hasData) {
          return ActiveWorkListView(
            activeWorks: snapshot.data.activeWorks,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Container(
          width: double.infinity,
          child: Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(kSecondaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ActiveWorkListView extends StatelessWidget {
  final List<ActiveWork> activeWorks;

  ActiveWorkListView({this.activeWorks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (_, index) {
        return ActiveWorkTile(activeWork: activeWorks[0]);
      },
    );
  }
}

class ActiveWorkTile extends StatelessWidget {
  final activeWork;

  ActiveWorkTile({this.activeWork});

  capitalize(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(kDefaultPadding * 0.5),
        leading: CachedNetworkImage(
            imageUrl: activeWork.service.getIconUrl(), height: 32, width: 32),
        title: Text(
          capitalize(activeWork.service.name),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          capitalize(activeWork.currentStatus),
          style: getStyle(activeWork.currentStatus),
        ),
        // trailing: MinuteCounter(
        //   initialCount: 10,
        // ),
        trailing: Icon(
          Icons.expand_more,
          size: 28,
          color: kPrimaryColor,
        ),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.white70),
            child: StatusStepper(activeWork: activeWork),
          ),
        ],
      ),
    );
  }
}

TextStyle getStyle(String string) {
  string = string.toUpperCase();
  Color color;
  if (string == "UNDETERMINED") {
    color = Colors.black;
  } else if (string == "ACCEPTED") {
    color = Colors.blue;
  } else if (string == "STARTED" || string == "RESUMED") {
    color = Colors.green;
    // color=kPrimaryColor;
  } else {
    color = Colors.deepOrange;
  }
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}
