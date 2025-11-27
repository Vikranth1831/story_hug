import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:story_hug/utils/constants.dart';

import '../../utils/media_query_helper.dart';
import '../../utils/spinkittsLoader.dart';

class SubSubCategoryCard extends StatelessWidget {
  final int index;
  final bool isTablet;

  final String title;
  final String? content;
  final String imageUrl;
  final int duration;
  final VoidCallback? onTap;

  const SubSubCategoryCard({
    Key? key,
    required this.index,
    required this.isTablet,

    required this.title,
    this.content,
    required this.imageUrl,
    required this.duration,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final h = size.height;
    return GestureDetector(onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                width: SizeConfig.screenWidth,
                height: isTablet ? h * 0.23 : h * 0.26,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  width: SizeConfig.screenWidth,
                  height: isTablet ? h * 0.23 : h * 0.26,
                  child: Center(child: spinkits.getSpinningLinespinkit()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: SizeConfig.screenWidth,
                  height: isTablet ? h * 0.23 : h * 0.26,
                  color: const Color(0xffF8FAFE),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 48,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // TITLE + DOWNLOAD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  capitalize(title),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff444444),
                  ),
                ),
                const Icon(Icons.download_rounded,
                    size: 26, color: Color(0xff444444)),
              ],
            ),


            SizedBox(
              height: 50,
              child: Html(
                data: """<p>$content</p>""",
                style: {
                  "p": Style(
                    color: Color(0xff333333),
                    fontSize: FontSize(12),
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    margin: Margins.zero,
                    maxLines: 2, // Supported inside Style
                    textOverflow: TextOverflow.ellipsis,
                  ),
                },
              ),
            ),
            // const SizedBox(height: 12),
            // Row(
            //   children: [
            //     const Icon(Icons.play_circle_fill,
            //         size: 28, color: Color(0xff444444)),
            //     const SizedBox(width: 6),
            //     Text(
            //       "$duration Minutes",
            //       style: const TextStyle(fontSize: 15, color: Color(0xff444444)),
            //     ),
            //     const Spacer(),
            //     GestureDetector(
            //       onTap: onPlayTap,
            //       child: Container(
            //         padding: EdgeInsets.symmetric(
            //           vertical: 10,
            //           horizontal: isTablet ? 18 : 14,
            //         ),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           gradient: const LinearGradient(
            //             colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
            //           ),
            //         ),
            //         child: const Row(
            //           children: [
            //             Icon(Icons.play_arrow_rounded,
            //                 color: Color(0xFF24305B), size: 20),
            //             SizedBox(width: 5),
            //             Text(
            //               "Play Now",
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.bold,
            //                 color: Color(0xFF24305B),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
