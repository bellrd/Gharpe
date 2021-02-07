import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/providers.dart';
import 'package:gharpay/screens/main_screen/main_screen.dart';
import 'package:tuple/tuple.dart';

import 'constant.dart';
import 'screens/offline_screen.dart';
import 'screens/update_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'ProductSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _getFirstScreen(), // make it future builder
    );
  }

  Widget _getFirstScreen() {
    var result = _checkForUpdate();

    int status = result.item1;
    String message = result.item2;

    if (status == 1) {
      return UpdateScreen(version: message);
    } else if (status == -1) {
      return OfflineScreen(error: message);
    } else {
      return AuthenticationWrapper();
    }
  }

  Tuple2<int, String> _checkForUpdate() {
    // 0 update not required
    // 1 update required
    // -1 some error occurred while checking for update
    // return Tuple2(1, "v 2.4.5");
    return Tuple2(0, "No internet connection");
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authenticationProvider);

    return user.when(
      data: (data) {
        if (data != null) return MainScreen();
        // return LoginScreen();
        return MainScreen();
      },
      loading: () => Container(),
      error: (e, s) => Center(child: Text("Error in login wrapper.")),
    );
  }
}
