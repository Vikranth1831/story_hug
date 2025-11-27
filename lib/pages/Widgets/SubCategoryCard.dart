import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../utils/spinkittsLoader.dart';

class SubCategoryCommonCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String? content;
  final bool isTablet;
  final VoidCallback? onTap;

  const SubCategoryCommonCard({
    Key? key,
    required this.imageUrl,
    required this.title,
     this.content,
    required this.isTablet,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF59399),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(color: Color(0x3F000000), blurRadius: 4),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                width: SizeConfig.screenWidth,
                height: isTablet ? h * 0.28 : h * 0.3,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                  width: SizeConfig.screenWidth,
                  height: isTablet ? h * 0.28 : h * 0.3,
                  child: Center(child: spinkits.getSpinningLinespinkit()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: SizeConfig.screenWidth,
                  height: isTablet ? h * 0.28 : h * 0.3,
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
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  TextStyle(
                color: Color(0xff333333),
                fontSize: 14,
                fontFamily: "Arial",
                fontWeight: FontWeight.w500,
              ),
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
          ],
        ),
      ),
    );
  }
}
