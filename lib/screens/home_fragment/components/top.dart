import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/models/service_model.dart';
import 'package:gharpay/screens/home_fragment/components/search_box.dart';
import 'package:gharpay/screens/home_fragment/components/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant.dart';
import 'custom_clipper.dart';

class Top extends StatefulWidget {
  final AsyncValue<ServiceList> futureServiceList;

  Top({this.futureServiceList});

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<String> locations = ["Gonda"];
  List<Service> services = List<Service>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.5),
            height: size.height * 0.4,
            decoration: BoxDecoration(color: kPrimaryColor),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      PopupMenuButton(
                        child: Row(
                          children: [
                            Text(
                              locations[0],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white70,
                              size: 20,
                            )
                          ],
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(
                              locations[0],
                              style: TextStyle(fontSize: 14),
                            ),
                            // height: 28,
                            value: 0,
                          ),
                        ],
                      ),
                      Spacer(),
                      FlatButton.icon(
                        onPressed: () async {
                          FirebaseAuth.instance.signOut();
                          // await context.read<AuthenticationService>().logout();
                          // locator<SharedPreferences>().remove('ACCESS_TOKEN');
                          var pref = await SharedPreferences.getInstance();
                          pref.remove('ACCESS_TOKEN');
                          print("logout");
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 0.5),
                  Text("Ghar ki services\n Ghar pe",
                      style: gharpay_slogan, textAlign: TextAlign.center),
                  SizedBox(height: kDefaultPadding * 1), // or 1.3,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    // child: SearchBox(services: this.services),
                    // child: FutureBuilder<ServiceList>(
                    //   future: this.widget.futureServiceList,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       return SearchBox(
                    //         services: snapshot.data.services,
                    //       );
                    //     }
                    //     return Text("Loading...");
                    //   },
                    // ),
                    child: widget.futureServiceList.when(
                      data: (data) => SearchBox(services: data.services),
                      loading: () => SearchBox(
                        services: [],
                      ),
                      error: (e, s) => Text("Restart application"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
