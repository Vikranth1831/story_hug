import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/utils/color_constants.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class ViewCardParts extends StatefulWidget {
  const ViewCardParts({super.key});

  @override
  State<ViewCardParts> createState() => _ViewCardPartsState();
}

class _ViewCardPartsState extends State<ViewCardParts> {
  bool isTablet = false;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    isTablet = w > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,

   //   appBar: CustomTopBar(onMenuTap: () {  },),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ---------------- BACKGROUND GRADIENT ----------------
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.17, 0.40, 0.66, 0.94],
            colors: [
              Color(0xFF303174),
              Color(0xFF5067AB),
              Color(0xFF7A7BA4),
              Color(0xFFF7DCAD),
              Color(0xFFE3C6D3),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // -------------------- BACK BUTTON --------------------
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 14 : 10,
                            horizontal: isTablet ? 22 : 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                          child: const Text(
                            "Back",
                            style: TextStyle(
                              fontFamily: "Arial Rounded MT Bold",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24305B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // -------------------- TITLE TEXTS --------------------
                  const Center(
                    child: Text(
                      "Indian Mythology",
                      style: TextStyle(
                        fontFamily: "Arial Rounded MT Bold",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Center(
                    child: Text(
                      "Ramayana",
                      style: TextStyle(
                        fontFamily: "Arial Rounded MT Bold",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFBD767),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // -------------------- GRID VIEW --------------------
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTablet ? 2 : 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: isTablet ? 1.1 : 0.85,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildStoryCard(index, h, w);
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================================
  //                          STORY CARD WIDGET
  // =====================================================================
  Widget _buildStoryCard(int index, double h, double w) {
    return Container(
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

          // -------------------- IMAGE --------------------
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/card1.jpg",   // your image
              height: isTablet ? h * 0.30 : h * 0.32,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // -------------------- PART NAME + DOWNLOAD --------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Part ${index + 1}",
                style: const TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff444444),
                ),
              ),

              const Icon(Icons.download_rounded,
                  size: 26,  color: Color(0xff444444),)
            ],
          ),

          const SizedBox(height: 12),

          // -------------------- PLAY ROW --------------------
          Row(
            children: [
              const Icon(Icons.play_circle_fill,
                  size: 28, color: Color(0xff444444),),

              const SizedBox(width: 6),

              Text(
                "${10 + index * 3} Minutes",
                style: const TextStyle(
                  fontFamily: "Arial Rounded MT Bold",
                  fontSize: 15,
                  color: Color(0xff444444),
                ),
              ),

              const Spacer(),

              // -------------------- PLAY NOW BUTTON --------------------
              GestureDetector(
                onTap: () {
                  context.push('/play-story');  // 🔥 Push to next screen
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 10 : 10,
                    horizontal: isTablet ? 16 : 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
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
    );
  }
}
