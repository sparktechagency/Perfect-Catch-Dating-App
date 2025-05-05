import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_app_bar.dart';
import '../../../../controllers/profile_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/custom_text.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfileData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: Obx(
            () => _profileController.profileLoading.value
            ? const Center(child: CustomPageLoading())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==============================> Profile picture section <=======================
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.profileImage}',
                    height: 369.h,
                    width: 402.w,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  //==============================> Edit Profile Button <=======================
                  Positioned(
                    right: 16.w,
                    top: 16.h,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.editProfileScreen);
                      },
                      child: SvgPicture.asset(AppIcons.edit),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              //==============================> My Bio section <=======================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 1.w, color: AppColors.borderColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //=====================> My profile & My photo album Row <=================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.r),
                                  bottomLeft: Radius.circular(24.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 4.h,
                                ),
                                child: CustomText(
                                  text: AppStrings.myProfile.tr,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            //========================> My photo album <========================
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.uploadPhotosScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24.r),
                                    bottomRight: Radius.circular(24.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22.w,
                                    vertical: 4.h,
                                  ),
                                  child: CustomText(
                                    text: AppStrings.myPhotoAlbum.tr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        //=====================> Name and Gender Row <=================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '${_profileController.profileModel.value.fullName!.capitalize}',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 3,
                                    bottom: 8.h,
                                  ),
                                  CustomText(text: '${_profileController.profileModel.value.gender!.capitalize}'),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(AppIcons.music),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        //=====================> Email Row <=================
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStrings.email.tr,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 3,
                                    bottom: 8.h,
                                  ),
                                  CustomText(
                                    text: '${_profileController.profileModel.value.email}',
                                    maxLine: 5,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        //=====================> Phone Number Row <=================
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStrings.phoneNumber.tr,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 3,
                                    bottom: 8.h,
                                  ),
                                  CustomText(
                                    text: '${_profileController.profileModel.value.location!.locationName}',
                                    maxLine: 5,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        //=====================> Location and Distance Row <=================
                        Row(
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
                                    text: '${_profileController.profileModel.value.location!.locationName}',
                                    maxLine: 5,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    if (_profileController.profileModel.value.language?.isEmpty ?? true)
                                      _languageText('No languages available'),
                                    ...( _profileController.profileModel.value.language ?? []).map((language) => _languageText(language)).toList(),

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
                                      '${_profileController.profileModel.value.dateOfBirth}' ?? 'N/A',
                                    ),
                                    _detailColumn(AppStrings.height.tr, '${_profileController.profileModel.value.height}'),
                                    _detailColumn(
                                      AppStrings.weight.tr,
                                      '${_profileController.profileModel.value.weight}',
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
                                      '${_profileController.profileModel.value.religion}',
                                    ),
                                    _detailColumn(
                                      AppStrings.qualification.tr,
                                      '${_profileController.profileModel.value.educationQualification}',
                                    ),
                                    _detailColumn(
                                      AppStrings.maritalStatus.tr,
                                      '${_profileController.profileModel.value.personalStatus}',
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
                          text: '${_profileController.profileModel.value.about}'
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
                            if (_profileController.profileModel.value.interested?.isEmpty ?? true)
                              _interestChip('No interests available'),
                            ...( _profileController.profileModel.value.interested ?? []).map((item) => _interestChip(item)).toList(),

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
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.w,
                                      mainAxisSpacing: 8.h,
                                      childAspectRatio: 0.9,
                                    ),
                                itemCount: _profileController.profileModel.value.photos!.length,
                                itemBuilder: (context, index) {
                                  return CustomNetworkImage(
                                    imageUrl:
                                    '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.photos![index]}',
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
              ),
              SizedBox(height: 32.h),
            ],
          ),
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
