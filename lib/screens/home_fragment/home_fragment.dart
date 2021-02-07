import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import 'components/bottom.dart';
import 'components/top.dart';

class HomeFragment extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    var futureServiceList = watch(serviceListProvider);
    return Column(
      children: [
        Top(futureServiceList: futureServiceList),
        Expanded(
            child: SingleChildScrollView(
                child: Bottom(futureServiceList: futureServiceList))),
      ], //do not add more children scroll issue : rather expand Bottom
    );
  }
}
