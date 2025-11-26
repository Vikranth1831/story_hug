import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubSubCategoryCard extends StatelessWidget {
  final int index;
  final bool isTablet;
  final VoidCallback? onPlayTap;

  const SubSubCategoryCard({
    Key? key,
    required this.index,
    required this.isTablet,
    this.onPlayTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 0)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/card1.jpg",
              height: isTablet ? 180 : 200, // 🔒 Fixed for masonry grid
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // TITLE + DOWNLOAD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Part ${index + 1}",
                style: const TextStyle(
                  fontFamily: "Arial",
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff444444),
                ),
              ),
              const Icon(Icons.download_rounded,
                  size: 26, color: Color(0xff444444)),
            ],
          ),

          const SizedBox(height: 12),

          // PLAY NOW SECTION
          Row(
            children: [
              const Icon(Icons.play_circle_fill,
                  size: 28, color: Color(0xff444444)),
              const SizedBox(width: 6),
              Text(
                "${10 + index * 3} Minutes",
                style: const TextStyle(
                  fontFamily: "Arial",
                  fontSize: 15,
                  color: Color(0xff444444),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onPlayTap ??
                        () => context.push('/play-story'), // default action
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 10 : 10,
                    horizontal: isTablet ? 16 : 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
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
                      Icon(Icons.play_arrow_rounded,
                          color: Color(0xFF24305B), size: 20),
                      SizedBox(width: 5),
                      Text(
                        "Play Now",
                        style: TextStyle(
                          fontFamily: "Arial",
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
