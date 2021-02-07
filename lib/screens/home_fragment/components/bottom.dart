import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/models/service_model.dart';
import 'package:gharpay/screens/home_fragment/components/service_card.dart';

import '../../../constant.dart';
import 'offer_slider.dart';

class Bottom extends StatefulWidget {
  final AsyncValue<ServiceList> futureServiceList;

  Bottom({this.futureServiceList});

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.3),
          child: widget.futureServiceList.when(
            data: (data) => ServiceListCard(services: data.services),
            loading: () => Center(child: Text("Loading")),
            error: (e,s) => Center(child:Text("Some error occured")),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.3),
          child: OfferSlider(),
        )
      ],
    );
  }
}
