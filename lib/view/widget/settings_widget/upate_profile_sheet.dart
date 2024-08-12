import 'package:firebase_msg/utils/show_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<void> updateProfileBottomSheet(BuildContext context) async {
  await showAppBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400]),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20)
                  .copyWith(bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset('assets/icons/camera.png',
                              fit: BoxFit.cover),
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/icons/picture.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Text(
                          'Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));
}
