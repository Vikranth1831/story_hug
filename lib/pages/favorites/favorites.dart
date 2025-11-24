import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> items = [
    {
      "image": "assets/images/card1.jpg",
      "title": "The Monkey & The Crocodile",
      "duration": "12 min",
      "fav": true,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // 🔥 FULL SCREEN BACKGROUND IMAGE
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.06),

                // Center Avatar
                Image.asset(
                  "assets/images/favoritesimage.png",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: h * 0.03),

                Text(
                  "Your Favorites",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                  ),
                ),

                SizedBox(height: h * 0.01),

                // Grid Items
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 2 : 1,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: w * 0.04,
                    mainAxisSpacing: h * 0.02,
                  ),
                  itemBuilder: (context, index) {
                    return _buildStoryCard(index, h, w, isTablet);
                  },
                ),

                SizedBox(height: h * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // STORY CARD WIDGET
  Widget _buildStoryCard(int index, double h, double w, bool isTablet) {
    final item = items[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE + HEART
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      item["image"],
                      height: isTablet ? h * 0.40 : h * 0.35,
                      width: w* 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          item["fav"] = !item["fav"];
                        });
                      },
                      child: Icon(
                        item["fav"] ? Icons.favorite : Icons.favorite_border,
                        color: item["fav"] ?Color(0xffF9E2A1) :Color(0xffF9E2A1),
                        size: isTablet ? 32 : 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              child: Text(
                item["title"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isTablet ? 18 : 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // DURATION + PLAY BUTTON
            Row(
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  size: 28,
                  color: Colors.white,
                ),

                const SizedBox(width: 6),

                Text(
                  item["duration"],
                  style: const TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 15,
                    color: Color(0xff444444),
                  ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: isTablet ? 16 : 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFCDB69),
                          Color(0xFFFCBF5D),
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F303000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Color(0xFF24305B),
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Play Now",
                          style: TextStyle(
                            fontFamily: "Arial Rounded MT Bold",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF24305B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
