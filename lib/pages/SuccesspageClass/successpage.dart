import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String titleText;
  final String buttonText;

  const SuccessPage({
    super.key,
    required this.titleText,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ---------- FULL BACKGROUND IMAGE ----------
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bgimage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- TOP LEFT LOGO ----------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 35,
                  ),
                ),

                // ---------- EVERYTHING CENTERED ----------
                Expanded(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // ---------- CENTER CONTENT ----------
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // <<< KEY LINE
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SUCCESS TICK IMAGE
                          Image.asset(
                            "assets/images/Check.png",
                            height: 150,
                            width: 150,
                          ),

                          const SizedBox(height: 20),

                          // TITLE TEXT
                          Center(
                            child: Text(
                              titleText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // BUTTON
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFCDB69),
                                    Color(0xFFFCBF5D),
                                  ],
                                ),
                              ),
                              child: Text(
                                buttonText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF24305B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
