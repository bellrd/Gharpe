import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/models/slider_model.dart';
import 'package:gharpay/providers.dart';
import 'package:gharpay/screens/home_fragment/components/text_style.dart';

import '../../../constant.dart';

class OfferCard extends StatelessWidget {
  AppSlider appSlider;

  OfferCard({this.appSlider});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(
        children: [
          Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding * 0.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultPadding * 0.5),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/900/400",
                  height: 400,
                  width: 900,
                  // appSlider.photo,
                  // fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
            child: Text(
              appSlider.headline,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Text(
              appSlider.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OfferSlider extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var futureAppSliderList = watch(appSliderListProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
          child: Text("What we do ?", style: servicesHeading),
        ),
        SizedBox(height: 10),
        futureAppSliderList.when(
          data: (data) => Container(
            height: 150,
            child: ListView.builder(
              itemCount: data.appSliders.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return OfferCard(appSlider: data.appSliders[index]);
              },
            ),
          ),
          loading: () => Container(
            child: Text("Loading..."),
          ),
          error: (e, s) => Center(child: Text("Network error.")),
        )
      ],
    );
  }
}
