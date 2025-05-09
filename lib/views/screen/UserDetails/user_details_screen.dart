/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/home_controller.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/helpers/time_formate.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/custom_app_bar.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getUsersProfilesDetails(userId: Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails.tr),
      body: SingleChildScrollView(
        child: Obx(() {
          if (homeController.isProfilesDetailsLoading.value) {
            return SizedBox(
              height: Get.height * .8,
              width: Get.width,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==============================> Profile picture section <=======================
              Obx(
                () => CustomNetworkImage(
                  imageUrl:
                      "${ApiConstants.imageBaseUrl}${homeController.user.value?.profileImage}",
                  height: 457.h,
                  width: 402.w,
                  borderRadius: BorderRadius.circular(8.r),
                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => CustomText(
                                          text:
                                              '${homeController.user.value == null ? "" : homeController.user.value!.fullName}' ??
                                              '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          maxLine: 3,
                                          bottom: 8.h,
                                        ),
                                      ),
                                      Obx(
                                        () => CustomText(
                                          text:
                                              '${homeController.user.value == null ? "" : homeController.user.value!.gender}' ??
                                              '',
                                        ),
                                      ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: AppStrings.location.tr,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        maxLine: 3,
                                        bottom: 8.h,
                                      ),
                                      Obx(
                                        () => CustomText(
                                          text:
                                              '${homeController.user.value == null ? "" : homeController.user.value!.location!.locationName}',
                                          maxLine: 5,
                                          textAlign: TextAlign.start,
                                        ),
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
                                        Obx(
                                          () => CustomText(
                                            text:
                                                '${homeController.user.value == null ? "" : homeController.user.value!.setDistance} away',
                                          ),
                                        ),
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
                                        if (homeController.user.value != null)
                                          for (
                                            int i = 0;
                                            i <
                                                homeController
                                                    .user
                                                    .value!
                                                    .language!
                                                    .length;
                                            i++
                                          )
                                            _languageText(
                                              homeController
                                                  .user
                                                  .value!
                                                  .language![i],
                                            ),
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
                                    Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _detailColumn(
                                            AppStrings.dateOfBirth.tr,
                                            homeController.user.value == null
                                                ? ""
                                                : TimeFormatHelper.formatDates(
                                                  homeController
                                                      .user
                                                      .value!
                                                      .dateOfBirth,
                                                ),
                                          ),
                                          _detailColumn(
                                            AppStrings.height.tr,
                                            homeController.user.value?.height
                                                .toString(),
                                          ),
                                          _detailColumn(
                                            AppStrings.maritalStatus.tr,
                                            homeController.user.value?.weight
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(color: AppColors.borderColor),
                                    Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _detailColumn(
                                            AppStrings.religion.tr,
                                            homeController.user.value?.religion,
                                          ),
                                          _detailColumn(
                                            AppStrings.qualification.tr,
                                            homeController
                                                .user
                                                .value
                                                ?.educationQualification,
                                          ),
                                          //TODO Politics not found
                                          // _detailColumn(
                                          //   AppStrings.politics.tr,
                                          //   'Moderate',
                                          // ),
                                        ],
                                      ),
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
                            //TODO about not found
                            CustomText(
                              text: "",
                              // text: homeController.user.value != null ? homeController.user.value!.abo : "",
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

                            //TODO interested not found
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
                            Obx(
                              () => Row(
                                children: [
                                  if (homeController.user.value != null)
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
                                        itemCount:
                                            homeController
                                                .user
                                                .value!
                                                .photos!
                                                .length,
                                        itemBuilder: (context, index) {
                                          return CustomNetworkImage(
                                            imageUrl:
                                                "${ApiConstants.imageBaseUrl}${homeController.user.value!.photos![index]}",
                                            height: 75.h,
                                            width: 70.w,
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
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
          );
        }),
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
  _detailColumn(String title, String? subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontWeight: FontWeight.w500),
        SizedBox(height: 8.h),
        CustomText(text: subTitle ?? '', fontSize: 12.sp),
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
*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/home_controller.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/helpers/time_formate.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/custom_app_bar.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final HomeController homeController = Get.put(HomeController());
  final userId = Get.parameters['id'];
  @override
  void initState() {
    super.initState();
    homeController.getUsersProfilesDetails(userId: '$userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profileDetails.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================> Profile picture section <=======================
            Obx(() {
              final user = homeController.user.value;
              return CustomNetworkImage(
                imageUrl: "${ApiConstants.imageBaseUrl}${user?.profileImage ?? ''}",
                height: 457.h,
                width: 402.w,
                borderRadius: BorderRadius.circular(8.r),
              );
            }),
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
                          Obx(() {
                            final user = homeController.user.value;
                            return Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: '${user?.fullName ?? 'Name not available'}',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        maxLine: 3,
                                        bottom: 8.h,
                                      ),
                                      CustomText(
                                        text: '${user?.gender ?? 'Gender not available'}',
                                      ),
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
                            );
                          }),
                          SizedBox(height: 24.h),
                          //=====================> Location and Distance Row <=================
                          Obx(() {
                            final user = homeController.user.value;
                            return Row(
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
                                        text: '${user?.location?.locationName ?? 'Location not available'}',
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
                                        CustomText(
                                          text: '${user?.setDistance ?? 'Distance not available'} away',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
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
                                      if(homeController.user.value != null)
                                        for (int i = 0; i < homeController.user.value!.language!.length; i++)
                                          _languageText(homeController.user.value!.language![i]),
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
                                        TimeFormatHelper.formatDates(homeController.user.value?.dateOfBirth),
                                      ),
                                      _detailColumn(
                                        AppStrings.height.tr,
                                        homeController.user.value?.height?.toString(),
                                      ),
                                      _detailColumn(
                                        AppStrings.maritalStatus.tr,
                                        homeController.user.value?.weight?.toString(),
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
                                        homeController.user.value?.religion,
                                      ),
                                      _detailColumn(
                                        AppStrings.qualification.tr,
                                        homeController.user.value?.educationQualification,
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
                            text: homeController.user.value?.about ?? 'About info not available',
                            maxLine: 20,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 24.h),
                          //========================> Interest Section <========================
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
                          //========================> Gallery GridView Section <========================
                          CustomText(
                            text: AppStrings.galleryPhoto.tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 16.h),
                          Obx(() {
                            final user = homeController.user.value;
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 0.9,
                              ),
                              itemCount: user?.photos?.length ?? 0,
                              itemBuilder: (context, index) {
                                return CustomNetworkImage(
                                  imageUrl: "${ApiConstants.imageBaseUrl}${user?.photos?[index] ?? ''}",
                                  height: 75.h,
                                  width: 70.w,
                                  borderRadius: BorderRadius.circular(16.r),
                                );
                              },
                            );
                          }),
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
  _detailColumn(String title, String? subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontWeight: FontWeight.w500),
        SizedBox(height: 8.h),
        CustomText(text: subTitle ?? '', fontSize: 12.sp),
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
