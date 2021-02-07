import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/providers.dart';
import 'package:gharpay/screens/home_fragment/home_fragment.dart';
import 'package:gharpay/screens/work_fragment/work_fragment.dart';

import 'components/bottom_appbar.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var fragmentIndex = watch(fragmentIndexProvider).state;

    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _getBody(fragmentIndex),
      ),
    );
  }
}

Widget _getBody(int index) {
  if (index == 0)
    return HomeFragment();
  else if (index == 1)
    return WorkFragment();
  else
    return Center(
      child: Text("Profile"),
    );
}
