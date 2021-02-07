import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gharpay/models/slider_model.dart';

import 'models/service_model.dart';

final authenticationProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final serviceListProvider =
    FutureProvider<ServiceList>((ref) => getServiceList());

final appSliderListProvider =
    FutureProvider<AppSliderList>((ref) => getAppSliderList());

final fragmentIndexProvider = StateProvider<int>((ref) => 0);
