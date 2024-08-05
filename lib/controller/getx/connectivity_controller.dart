import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  RxBool _hasInternet = false.obs;
  RxBool get hasInternet => _hasInternet;

  Future<void> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet = false.obs;
    } else {
      log(_hasInternet.value.toString(), name: 'Connectivity');
      _hasInternet = true.obs;
    }
  }
}
