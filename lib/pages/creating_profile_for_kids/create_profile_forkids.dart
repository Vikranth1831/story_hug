import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';



class CreateProfileForkids extends StatelessWidget {
  const CreateProfileForkids({super.key});

  @override
  Widget build(BuildContext context) {
    var w=SizeConfig.screenWidth;
    var h=SizeConfig.screenHeight;
    return Scaffold(
      backgroundColor: Color(0xFF192346),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: w * 0.035),
        child: Column(

          children: [
            SizedBox(height: h * 0.05,),
            Center(child: Image.asset('assets/images/Group 146.png')),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Create Profile\n',
                    style: TextStyle(
                      color: const Color(0xFFF5F5F5),
                      fontSize: 27,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: 0.54,
                    ),
                  ),
                  TextSpan(
                    text: 'for KIDS',
                    style: TextStyle(
                      color: const Color(0xFFF5F5F5),
                      fontSize: 22.5,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: 0.44,
                    ),
                  ),

                ],
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/all_children.png'),

          ],

        ),
      ),
      bottomNavigationBar: SafeArea(
          child:
          InkWell(
            onTap: ()
              {
                context.push('/entering_fields_for_kids');
              },
              child: CreateNowButton(text: 'Create Now',)
          )
      ),
    );
  }


}
