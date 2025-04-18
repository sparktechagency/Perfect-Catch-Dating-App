import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //=======================> Background Image <=========================
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onboardingImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //=======================> Logo Container <===========================
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3.h,
            left: 24.w,
            right: 24.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.9),
                borderRadius: BorderRadius.circular(32.r),
                border: Border.all(width: 1.w, color: Colors.white),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                child: Column(
                  children: [
                    //=====================> App Logo <=========================
                    Image.asset(AppImages.appLogo),
                    SizedBox(height: 32.h),
                    //=============> Find Love Friendship Text <================
                    CustomText(
                      text: AppStrings.findLoveFriendship.tr,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 10,
                    ),
                    SizedBox(height: 16.h),
                    //================> Our App Offers Text <===================
                    CustomText(
                      text: AppStrings.ourAppOffers.tr,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 10,
                    ),
                    SizedBox(height: 32.h),
                    //=================> Get Started Button <===================
                    CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.selectModeScreen);
                        },
                        text: AppStrings.getStarted.tr),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
