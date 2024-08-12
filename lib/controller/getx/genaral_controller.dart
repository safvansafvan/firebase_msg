import 'dart:developer';

import 'package:get/get.dart';

class GenaralController extends GetxController {
  double sliderVibrationValue = 40;

  void sliderState(double value) {
    sliderVibrationValue = value;
    log(sliderVibrationValue.toString(), name: 'SLIDER VALUE');
    update();
  }
}
