import 'package:flutter/material.dart';

class Subscribepage extends StatefulWidget {
  const Subscribepage({super.key});

  @override
  State<Subscribepage> createState() => _SubscribepageState();
}

class _SubscribepageState extends State<Subscribepage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ⭐ Background Image
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png",),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: h * 0.08),

              // ⭐ Centered Top Illustration
              Image.asset(
                "assets/images/favoritesimage.png", // change to your image
                width: w * 0.55,
              ),

              SizedBox(height: h * 0.03),

              // ⭐ TRANSPARENT CONTAINER (Same as UI screenshot)
              Container(
                width: w * 0.90,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12), // transparent effect
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0x7F73CCFE),  // your color
                    width: 2,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Unlock the magic within",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    // ⭐ ILLUSTRATION UNDER HEADING (Like UI)
                    Image.asset(
                      "assets/images/subscribe.png",
                      height: h * 0.4,// replace with your story illustration
                      width: w * 0.8,
                    ),

                    SizedBox(height: 5),

                    // ⭐ PLANS ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Free Plan Box
                        _buildPlanBox(
                          title: "Free",
                          features: [
                            "5 Stories",
                            "No Child Profile",
                            "No Video Cloning",
                            "No Listen Offline"
                          ],
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                        ),

                        // Premium Plan Box
                        _buildPlanBox(
                          title: "Premium",
                          features: [
                            "Unlimited Stories",
                            "Multiple Child Profile",
                            "Unlock all voices",
                            "Listen Offline"
                          ],
                          buttonColor: Color(0xFFFFD363),
                          textColor: Colors.black,
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Starts at ₹ 99 per Month",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ⭐ PLAN BOX WIDGET
  Widget _buildPlanBox({
    required String title,
    required List<String> features,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Container(
      width: 130,
      height: 180,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
       // color: Colors.white.withOpacity(0.10),
     //   color: Colors.white.withOpacity(0.10),
        color: const Color(0xFF2F3C74),
        borderRadius: BorderRadius.circular(16),

      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...features
              .map((f) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              f,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ))
              .toList(),

          const SizedBox(height: 10),

          // BUTTON
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
