import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityCtrl extends GetxController {
  RxBool _hasInternet = false.obs;
  RxBool get hasInternet => _hasInternet;

  Future<void> checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _hasInternet = false.obs;
    } else {
      _hasInternet = true.obs;
    }
  }
}
