import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:go_router/go_router.dart';

import '../../services/AuthService.dart';

class LogoutDialog extends StatelessWidget {
  final Color primaryColor;

  const LogoutDialog({
    Key? key,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 4.0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: 300.0,
        height: 230.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Power Icon Positioned Above Dialog
            Positioned(
              top: -35.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                width: 70.0,
                height: 70.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 6.0, color: Colors.white),
                  shape: BoxShape.circle,
                  color: Colors.red.shade100, // Light red background
                ),
                child: const Icon(
                  Icons.power_settings_new,
                  size: 40.0,
                  color: Colors.red,
                ),
              ),
            ),

            // Main Dialog Content
            Positioned.fill(
              top: 30.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15.0),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        fontFamily: "roboto_serif",
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Are you sure you want to logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                        fontFamily: "roboto_serif",
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // No Button (Filled)
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "roboto_serif",
                              ),
                            ),
                          ),
                        ),

                        // Yes Button (Outlined)
                        SizedBox(
                          width: 100,
                          child: OutlinedButton(
                            onPressed: () async {
                              await AuthService.logout();
                              Get.offAllNamed('/login');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryColor,
                              side: BorderSide(color: primaryColor),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "roboto_serif",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
