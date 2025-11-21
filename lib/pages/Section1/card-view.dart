import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class SelectedCardView extends StatefulWidget {
  const SelectedCardView({super.key});

  @override
  State<SelectedCardView> createState() => _SelectedCardViewState();
}

class _SelectedCardViewState extends State<SelectedCardView> {
  // ------------------- Sample Story Data -------------------
  final List<Map<String, dynamic>> stories = [
    {
      "image": "assets/images/mahabharath.png",
      "title": "Mahabharata",
      "description":
      "The great epic describing the Kurukshetra war between Kauravas and Pandavas.",
    },
    {
      "image": "assets/images/ramayana.png",
      "title": "Ramayana",
      "description":
      "The story of Lord Rama, his exile, and the rescue of Sita from Ravana.",
    },
    {
      "image": "assets/images/mytholgy.png",
      "title": "Shiva Purana",
      "description":
      "Narrates legends of Lord Shiva, his cosmic powers, and divine stories.",
    },
    {
      "image": "assets/images/mytholgy.png",
      "title": "Vishnu Purana",
      "description":
      "Explains the creation of the universe and the incarnations of Lord Vishnu.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ------------------ SCREEN SIZE ------------------
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;
    int gridCount = isTablet ? 2 : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFACBCF1),
      appBar: AppBar(
        backgroundColor: Color(0xFFACBCF1),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "AppBar",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),

      // ---------------------- BODY ----------------------
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.02),

            // ------------------ BACK BUTTON ------------------
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: h * 0.01, horizontal: w * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      // ---------- GRADIENT COLORS ----------
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFCDB69),
                          Color(0xFFFCBF5D),
                        ],
                      ),

                      // ---------- BOX SHADOW ----------
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

            Center(
              child: Column(
                children: const [
                  Text(
                    "Indian Mythology",
                    style: TextStyle(
                      fontFamily: "Arial Rounded MT Bold",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // ------------------ LIST OF STORY CARDS ------------------
            Expanded(
              child: GridView.builder(
                itemCount: stories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  childAspectRatio: isTablet ? 1.1 : 0.95,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: h * 0.02,
                ),
                itemBuilder: (context, index) {
                  final story = stories[index];

                  return GestureDetector(
                    onTap: () {
                      context.push('/selectedStory');  // <--- 🔥 ADDED HERE
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFF3C5),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF333333),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ------------------ IMAGE ------------------
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              story["image"],
                              height: isTablet ? h * 0.3 : h * 0.3,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: h * 0.013),

                          // ------------------ TITLE ------------------
                          Text(
                            story["title"],
                            style: const TextStyle(
                              fontFamily: "Arial Rounded MT Bold",
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: h * 0.006),

                          // ------------------ DESCRIPTION ------------------
                          Text(
                            story["description"],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: "Arial Rounded MT Bold",
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
