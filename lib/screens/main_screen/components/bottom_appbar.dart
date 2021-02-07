import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/providers.dart';

import '../../../constant.dart';

class CustomAppBar extends ConsumerWidget {
  final List<BottomNavigationBarItem> barItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_work_outlined),
      activeIcon: Icon(Icons.home_work),
      backgroundColor: Colors.white,
      label: "Services",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.watch_later_outlined),
      activeIcon: Icon(Icons.watch_later_rounded),
      backgroundColor: Colors.white,
      label: "Active work",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      activeIcon: Icon(Icons.account_circle),
      backgroundColor: Colors.white,
      label: "Profile",
    )
  ];
  final TextStyle style =
      TextStyle(fontWeight: FontWeight.normal, color: Colors.black);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var fragmentIndex = watch(fragmentIndexProvider).state;
    return BottomNavigationBar(
      elevation: 8,
      iconSize: 24,
      // selectedFontSize: 15,
      fixedColor: kSecondaryColor,
      selectedLabelStyle: TextStyle(fontFamily: "ProductSans"),
      items: barItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: fragmentIndex,
      onTap: (index) {
        context.read(fragmentIndexProvider).state = index;
      },
    );
  }
}
