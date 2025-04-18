import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({super.key});

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  List<bool> selectedModes = [false, false, false, false];
  RxList<bool> selectedOptions = [false, false, false, false, false, false].obs;

  final List<Map<String, String>> modeOptions = [
    {'icon': 'person', 'title': AppStrings.bestFriend.tr, 'subtitle': AppStrings.openBestFriendMode.tr},
    {'icon': 'person', 'title': AppStrings.relationship.tr, 'subtitle': AppStrings.openRelationshipMode.tr},
    {'icon': 'person', 'title': AppStrings.poly.tr, 'subtitle': AppStrings.openPolyMode.tr},
    {'icon': 'person', 'title': AppStrings.arrangeMarriage.tr, 'subtitle' : AppStrings.openArrangeMarriageMode.tr},
  ];

  void onModeSelected(int index) {
    setState(() {
      selectedModes = List.generate(modeOptions.length, (i) => i == index);
    });
  }




  final List<String> options = [
    AppStrings.aLongTermRelationship.tr,
    AppStrings.fanCasualDates.tr,
    AppStrings.aWhirlwindRomance.tr,
    AppStrings.friendsWithBenefits.tr,
    AppStrings.seriousCommitment.tr,
    AppStrings.openRelationship.tr
  ];


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
        child: Center(
          child: Column(
            children: [
              CustomText(
                text: AppStrings.chooseYourMode.tr,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                bottom: 16.h,
              ),
              CustomText(
                text: AppStrings.pleaseSelectAnOneOption.tr,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                maxLine: 3,
                bottom: 32.h,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: modeOptions.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onModeSelected(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color:
                          selectedModes[index]
                              ? AppColors.primaryColor.withOpacity(0.1)
                              : const Color(0xFFE5F4F9),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color:
                            selectedModes[index]
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            width: 2.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12.w,
                              height: 99.h,
                              decoration: BoxDecoration(
                                color:
                                selectedModes[index]
                                    ? AppColors.primaryColor
                                    : const Color(0xFF056C6E),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  bottomLeft: Radius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Profile Icon
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1EBF4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.person,
                                color:
                                selectedModes[index]
                                    ? AppColors.primaryColor
                                    : const Color(0xFF056C6E),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: modeOptions[index]['title']!,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    text: modeOptions[index]['subtitle']!,
                                    fontSize: 14.sp,
                                    maxLine: 3,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            //====================> Custom Checkbox Design <=======================
                            Checkbox(
                              value: selectedModes[index],
                              onChanged: (value) => onModeSelected(index),
                              activeColor: AppColors.primaryColor,
                              checkColor: Colors.white,
                              side: BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //=========================> Continue Button <====================
              CustomButton(
                onTap: _showBottomSheet,
                text: AppStrings.continues.tr,
              ),
              SizedBox(height: 48.h)
            ],
          ),
        ),
      ),
    );
  }
//=============================> Bottom sheet <==========================
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                SizedBox(
                  height: 12.h,
                  width: 48.w,
                    child: Divider(thickness: 4.9, color: Colors.grey)),
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.youCanChooseOption.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 16.h),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Obx(()=> Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.w, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(16.r)
                      ),
                      child: CheckboxListTile(
                        key: Key('$index-${selectedOptions[index]}'),
                        activeColor: AppColors.primaryColor,
                        checkColor: Colors.white,
                        side: BorderSide(color: AppColors.primaryColor, width: 1.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        title: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(text: options[index])),
                        value: selectedOptions[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions[index] = value!;
                          });
                        },
                      ),
                    ),
                    );
                  },
                ),
                CustomButton(onTap: (){Get.offAllNamed(AppRoutes.homeScreen);}, text: AppStrings.save.tr),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }

}
