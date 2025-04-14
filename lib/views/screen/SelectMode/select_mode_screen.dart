import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  List<bool> selectedModes = [false, false, false];

  final List<Map<String, String>> modeOptions = [
    {'icon': 'person', 'title': 'Best Friend', 'subtitle': 'Open Best Friend Mode'},
    {'icon': 'person', 'title': 'Family', 'subtitle': 'Open Family Mode'},
    {'icon': 'person', 'title': 'Partner', 'subtitle': 'Open Partner Mode'},
  ];

  void onModeSelected(int index) {
    setState(() {
      selectedModes = List.generate(modeOptions.length, (i) => i == index);
    });
  }

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
                            width: 2,
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
                                  ),
                                ],
                              ),
                            ),
                            // Custom Checkbox Design
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
              CustomButton(
                onTap: () {},
                text: AppStrings.continues.tr,
              ),
              SizedBox(height: 32.h)
            ],
          ),
        ),
      ),
    );
  }
}
