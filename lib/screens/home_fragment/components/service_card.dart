import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gharpay/models/service_model.dart';
import 'package:gharpay/screens/home_fragment/components/text_style.dart';

import '../../../constant.dart';



class ServiceCard extends StatelessWidget {
  Service service;

  ServiceCard({service: Service}) {
    this.service = service;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // height: 90,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:service.getIconUrl(),
              width: 48,
              height: 48,
            ),
            SizedBox(
              height: 5,
            ),
            Text(service.name, style: serviceName)
          ],
        ),
      ),
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => DetailScreen(service: this.service)));
      },
    );
  }
}

class ServiceListCard extends StatelessWidget {
  List<Service> _services;

  ServiceListCard({services: List}) {
    this._services = services;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.1, vertical: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.2),
              child: Text("Our popular services", style: servicesHeading),
            ),
            ...buildServiceRows(_services)
          ],
        ),
      ),
    );
  }
}

List<Widget> buildServiceRows(List<Service> services) {
  /*
    sl ===  list of ServiceCard
   */
  List<ServiceCard> sl = List<ServiceCard>();
  services.forEach(
    (element) => sl.add(
      ServiceCard(
        service: element,
      ),
    ),
  );

  /*
    wl === list of widgets
   */

  List<Widget> wl = List<Widget>();
  for (int i = 0; i <= sl.length; i += 3) {
    wl.add(
      SizedBox(
        height: 20,
      ),
    );

    wl.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sl.skip(i).take(3).toList(),
      ),
    );
  }
  return wl;
}
