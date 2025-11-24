import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;
    int gridCount = isTablet ? 4 : 2;

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
      backgroundColor: const Color(0xFFACBCF1),
      appBar: CustomTopBar(),
      body: CustomScrollView(
        slivers: [
          // -----------------------------------------------------------------
          // FIXED SLIVER APPBAR
          // -----------------------------------------------------------------


          // -----------------------------------------------------------------
          // HELLO + VIKRANTH (scrolls away)
          // -----------------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02),

                  const Text(
                    "Hello",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Arial Rounded MT Bold",
                    ),
                  ),

                  SizedBox(height: h * 0.005),

                  const Text(
                    "Vikranth",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Arial Rounded MT Bold",
                    ),
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // PROFESSIONAL SLIVER GRID
          // -----------------------------------------------------------------
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () => context.push('/select'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: item["color"],
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              item["image"],
                              height: isTablet ? h * 0.20 : h * 0.16,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: h * 0.015),

                          Text(
                            item["title"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Arial Rounded MT Bold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCount,
                childAspectRatio: 0.75,
                crossAxisSpacing: w * 0.03,
                mainAxisSpacing: h * 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
