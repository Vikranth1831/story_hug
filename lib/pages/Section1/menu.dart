import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen size
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    // Check tablet
    bool isTablet = w > 600;

    // Grid columns
    int gridCount = isTablet ? 4 : 2;

    // Card items
    final List<Map<String, dynamic>> items = [
      {
        "title": "Indian Mythology & Divine Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFF59399),
      },
      {
        "title": "Indian Kings & Warriors Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFFDD33B),
      },
      {
        "title": "Motivational & Success Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFFAF4EA),
      },
      {
        "title": "Great Inventions & Inventors",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFD6D7FF),
      },
    ];

    return Scaffold(
      backgroundColor: Color(0xFFACBCF1),

      appBar: AppBar(
        backgroundColor: Color(0xFFACBCF1),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "AppBar",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.02),

            // ------------------ HELLO TEXT ------------------
            Center(
              child: const Text(
                "Hello",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: "Arial Rounded MT Bold",
                ),
              ),
            ),

            SizedBox(height: h * 0.005),

            Center(
              child: const Text(
                "Vikranth",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 38,
                  fontFamily: "Arial Rounded MT Bold",
                ),
              ),
            ),

            SizedBox(height: h * 0.03),

            // ------------------ GRID VIEW ------------------
            Expanded(
              child: GridView.builder(
                itemCount: items.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: w * 0.03,
                  mainAxisSpacing: h * 0.02,
                ),

                itemBuilder: (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () {
                      context.push('/select');
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: item["color"],
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 0),
                          ),
                          BoxShadow(
                            color: Color(0x99000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(w * 0.03),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              item["image"],
                              height: isTablet ? h * 0.2 : h * 0.16,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: h * 0.015),

                          // TITLE
                          Text(
                            item["title"],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Arial Rounded MT Bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
