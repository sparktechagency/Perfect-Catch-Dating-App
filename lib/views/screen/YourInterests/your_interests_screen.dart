import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class YourInterestsScreen extends StatefulWidget {
  const YourInterestsScreen({super.key});

  @override
  State<YourInterestsScreen> createState() => _YourInterestsScreenState();
}

class _YourInterestsScreenState extends State<YourInterestsScreen> {
  final List<String> interests = [
    'Reading',
    'Photography',
    'Gaming',
    'Music',
    'Travel',
    'Painting',
    'Politics',
    'Cooking',
    'Pets',
    'Charity',
    'Sports',
    'Fashion',
  ];
  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            text: AppStrings.skip.tr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration.underline,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            //===============================> Your Interests <=======================
            Center(
              child: CustomText(
                text: AppStrings.yourInterests.tr,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                bottom: 14.h,
              ),
            ),
            Center(
              child: CustomText(
                text: AppStrings.selectAFewOfYour.tr,
                maxLine: 5,
                bottom: 32.h,
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  interests.map((interest) {
                    return ChoiceChip(
                      showCheckmark: false,
                      label: CustomText(
                        text: interest,
                        color:
                            selectedInterests.contains(interest)
                                ? Colors.white
                                : Colors.black,
                      ),
                      side: BorderSide(
                        width: 1.w,
                        color: AppColors.primaryColor,
                      ),
                      selected: selectedInterests.contains(interest),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedInterests.add(interest);
                          } else {
                            selectedInterests.remove(interest);
                          }
                        });
                      },
                      selectedColor: AppColors.primaryColor,
                      backgroundColor: Colors.white,
                    );
                  }).toList(),
            ),
            Spacer(),
            CustomButton(onTap: () {}, text: AppStrings.submit.tr),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
