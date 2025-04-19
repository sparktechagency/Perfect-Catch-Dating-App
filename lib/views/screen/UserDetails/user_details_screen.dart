import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/custom_app_bar.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================> Profile picture section <=======================
            CustomNetworkImage(
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/0070/a04d/2bab51a081e3a54b73822719d5e8134d?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oMLhkNk-ooLwpMYnX7bt1Ny0ohotznWdrlMOZUtiQa9~S1eOzX3OQuNH3bm9LIvy607skMewOPXx1mD4OMNL34gV~f3Yhxbp3q0slXWMz90GqpWl6xZUg20d~-z~8wVEcikLNQY0zd4HcRHrC8-B1NWQcZ7AREFEjU907jwn8nIGdZNjV72CnLIh~jFcDe~b13KPBefghmIkfoq72fnsDmHYW7udlvsCZHSjWKKUwYX5nwB0AJDcXhvs7PMnv-Dg2U5Z5Waz2RxQc1A9dhtVmwP13ZPDcozOfwZPCJawNFXa2O5ksggFQo-d2cMxDt4sgMxh4LU3e5h1aAMMf2bCsQ__',
              height: 457.h,
              width: 402.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 32.h),
            //==============================> My Bio section <=======================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.borderColor,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 32.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //=====================> Name and Gender Row <=================
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Leilani Adam',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 3,
                                      bottom: 8.h,
                                    ),
                                    CustomText(text: 'Female'),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.messageScreen);
                                },
                                child: SvgPicture.asset(AppIcons.message),
                              ),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(AppIcons.music),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Location and Distance Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.location.tr,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 3,
                                      bottom: 8.h,
                                    ),
                                    CustomText(
                                      text: 'Chicago, IL United States',
                                      maxLine: 5,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 8.h,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppIcons.location),
                                      SizedBox(width: 4.w),
                                      CustomText(text: '1.3 km away'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Language Container <=================
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.borderColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: CustomText(
                                    text: AppStrings.language.tr,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Divider(color: AppColors.borderColor),
                                SizedBox(height: 8.h),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _languageText('English'),
                                      _languageText('Bangla'),
                                      _languageText('Hindi'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Details Container <=================
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _detailColumn(
                                        AppStrings.dateOfBirth.tr,
                                        '1-10-1995',
                                      ),
                                      _detailColumn(
                                        AppStrings.height.tr,
                                        '6.1 In',
                                      ),
                                      _detailColumn(
                                        AppStrings.maritalStatus.tr,
                                        'Single',
                                      ),
                                    ],
                                  ),
                                  Divider(color: AppColors.borderColor),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _detailColumn(
                                        AppStrings.religion.tr,
                                        'Islam',
                                      ),
                                      _detailColumn(
                                        AppStrings.qualification.tr,
                                        'BSC',
                                      ),
                                      _detailColumn(
                                        AppStrings.politics.tr,
                                        'Moderate',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          //=====================> About <=================
                          CustomText(
                            text: AppStrings.about.tr,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            bottom: 8.h,
                          ),
                          CustomText(
                            text:
                                'Hello there! I\'m Vickie, seeking a lifelong adventure partner. A blend of tradition and modernity, I find joy in the simple moments and cherish family values. With a heart that believes in love\'s magic, I\'m looking someone to share happiness.'
                                    .tr,
                            maxLine: 20,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 24.h),
                          //========================> Interest Section <==========================
                          CustomText(
                            text: AppStrings.interests.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              _interestChip('Reading'),
                              _interestChip('Music'),
                              _interestChip('Sports'),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //========================> Gallery GridView Section <==========================
                          CustomText(
                            text: AppStrings.galleryPhoto.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.w,
                                        mainAxisSpacing: 8.h,
                                        childAspectRatio: 0.9,
                                      ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return CustomNetworkImage(
                                      imageUrl:
                                          'https://s3-alpha-sig.figma.com/img/df34/29c4/c71ac3e69c9a56da15e2d40a3f795600?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YqV-XMLYyQqcR9TcJgDoD5eZ3f8625iwAko3bkSKpDBfP-wINPufcCka3ubtozcrS7stJMyH44ci16Ud8ZXlmhJCAnXNcmvAVtG9EnLLQsSttwCdo3RyzdofIAwO9AIno~iilcvmuRaQg-REsoYMCM3hc4PXa6Pj1vzLNIsGzBRZPQe3dRQaRyDvaLjx8961rSR3HqJGb-d6UKuOJ~YAzw7Y5oxPnQfhwYJHCJdPmEAHjjl7ThFviqE4LfGfZYLU17Q6M1tJTlH~6WOcDLRJtZAe~KD1Ob6U8A4lwwFF3Aue-iNDD1BaZAMQi-EMaTIIFy~aEaGFPSIpyW4WS7floA__',
                                      height: 75.h,
                                      width: 70.w,
                                      borderRadius: BorderRadius.circular(16.r),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15.w,
                    top: -18.h,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 22.w,
                          vertical: 4.h,
                        ),
                        child: CustomText(
                          text: AppStrings.myBio.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  //===============================> Language Text <======================
  _languageText(String language) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: CustomText(text: language, color: Colors.white),
      ),
    );
  }

  //===============================> _Detail Column <======================
  _detailColumn(String title, subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontWeight: FontWeight.w500),
        SizedBox(height: 8.h),
        CustomText(text: subTitle, fontSize: 12.sp),
      ],
    );
  }

  //======================================> Interest Chip <========================
  _interestChip(String label) {
    return Chip(
      label: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: CustomText(text: label, color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
    );
  }
}
