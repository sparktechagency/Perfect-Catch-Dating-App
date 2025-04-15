/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class YourInterestsScreen extends StatefulWidget {
  const YourInterestsScreen({super.key});

  @override
  State<YourInterestsScreen> createState() => _YourInterestsScreenState();
}

class _YourInterestsScreenState extends State<YourInterestsScreen> {




  void toggleInterest(String interest) {
    setState(() {
      if (_interestController.selectedInterests.contains(interest)) {
        _interestController.selectedInterests.remove(interest);
      } else {
        _interestController.selectedInterests.add(interest);
      }
      print('============> ${_interestController.selectedInterests}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.yourInterests.tr),
      body: Obx(
        () => Padding(
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
                  maxLine: 2,
                  bottom: 32.h,
                ),
              ),
              Expanded(
                child: MasonryGridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  crossAxisCount: 2,
                  itemCount: _interestController.categoryModel.length,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  itemBuilder: (context, index) {
                    var data = _interestController.categoryModel[index];
                    bool isSelected = _interestController.selectedInterests
                        .contains(data.id);
                    return InkWell(
                      onTap: () => toggleInterest('${data.id}' ?? ''),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primaryColor
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        child: Center(
                          child: CustomText(
                            text: '${data.categoryName}' ?? '',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(onTap: () {}, text: AppStrings.submit.tr),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
*/
