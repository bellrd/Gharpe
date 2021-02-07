import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/models/active_work_model.dart';
import 'package:gharpay/providers.dart';

import '../../constant.dart';
import 'components/active_work_widget.dart';
import 'components/past_work_widget.dart';

class WorkFragment extends StatefulWidget {
  StreamController<ActiveWorkList> activeWorkStreamController =
      StreamController.broadcast();

  @override
  _WorkFragmentState createState() => _WorkFragmentState();
}

class _WorkFragmentState extends State<WorkFragment> {
  var filterList = ['Active Work', 'Past Work'];
  int filterIndex = 0;

  Future<void> refreshList() async {
    if (filterIndex == 0) {
      var al = await getActiveWorkList();
      widget.activeWorkStreamController.add(al);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.5,
              vertical: kDefaultPadding * 0.5),
          height: size.height * 0.25,
          decoration: BoxDecoration(color: kPrimaryColor),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        context.read(fragmentIndexProvider).state = 0;
                      },
                      color: Colors.white,
                    ),
                    PopupMenuButton(
                      onSelected: (value) {
                        refreshList();
                        setState(() {
                          filterIndex = value;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            filterList[filterIndex],
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      itemBuilder: (context) => <PopupMenuItem<int>>[
                        PopupMenuItem(
                          child: Text(filterList[0]),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(filterList[1]),
                          value: 1,
                        ),
                      ],
                    )
                  ],
                ),
                // Spacer(),
                Center(
                  child: Text(
                    "${filterIndex == 0 ? "Work currently in progress" : "Completed works"}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Click on card to expand",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 0.1,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filterList[filterIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Refreshing "),
                    ),
                  );
                  refreshList();
                },
                icon: Icon(
                  Icons.refresh_outlined,
                  color: kSecondaryColor,
                ),
                label: Text(
                  "Refresh",
                  style: TextStyle(color: kSecondaryColor),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
            child: filterIndex == 0
                ? ActiveWorkWidget(
                    streamController: widget.activeWorkStreamController)
                : PastWorkWidget(),
          ),
        ),
      ],
    );
  }
}
