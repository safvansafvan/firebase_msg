import 'package:firebase_msg/controller/getx/genaral_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/widget/settings_widget/settings_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenaralScreen extends StatelessWidget {
  const GenaralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: settingsBg,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            phoneVibration();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: false,
        title: const Text(
          'Genaral',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.7),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: Text(
                'Notification',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: helpTextColor),
              ),
            ),
            const CardWidget(
              icon: Icons.notifications_outlined,
              label: 'Message Notification',
              action: true,
            ),
            const CardWidget(
              icon: Icons.notifications_outlined,
              label: 'App Notification',
              action: true,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    'Vibration',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: helpTextColor),
                  ),
                ),
                const CardWidget(
                  icon: Icons.keyboard_alt_outlined,
                  label: 'Keyboard Haptics',
                  action: true,
                ),
                const CardWidget(
                  icon: Icons.vibration_rounded,
                  label: 'Vibration',
                  action: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 10),
                  child: Text(
                    'Vibration Level',
                    style: TextStyle(color: helpTextColor),
                  ),
                ),
                GetBuilder<GenaralController>(builder: (genaralController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(
                          width: context.width - 50,
                          child: CupertinoSlider(
                            value: genaralController.sliderVibrationValue,
                            max: 60,
                            min: 40,
                            onChanged: (value) {
                              phoneVibration();
                              genaralController.sliderState(value);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Level : ${genaralController.sliderVibrationValue.toInt().toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
