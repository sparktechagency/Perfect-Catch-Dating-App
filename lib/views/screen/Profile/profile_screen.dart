import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/views/base/custom_list_tile.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import '../../../controllers/profile_controller.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../service/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_button.dart';
import '../../base/custom_page_loading.dart';
import '../../base/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    _profileController.getProfileData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(4),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.profile.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Obx(
            () => _profileController.profileLoading.value
            ? const Center(child: CustomPageLoading())
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Card(
              elevation: 5.5,
              shadowColor: AppColors.primaryColor,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Center(
                  child: Column(
                    children: [
                      //====================> User Profile Image <====================
                      CustomNetworkImage(
                        imageUrl:
                        '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.profileImage}',
                        height: 135.h,
                        width: 135.w,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      //=========================> User Name <========================
                      CustomText(
                        text: '${_profileController.profileModel.value.fullName}',
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 24.h),
                      //===================> Subscription Container <=================
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            width: 2.w,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppIcons.sub),
                              SizedBox(width: 8.w),
                              //===================> Subscription Pack <================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStrings.basicPackage.tr,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    text: AppStrings.months.tr,
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                              Spacer(),
                              //===================> Explore Button <================
                              CustomButton(
                                onTap: () {
                                  Get.toNamed(AppRoutes.subscriptionScreen);
                                },
                                text: AppStrings.explore.tr,
                                fontSize: 10.sp,
                                width: 80.w,
                                height: 27.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      //===================> Personal Information ListTile <=================
                      CustomListTile(
                        onTap: (){
                          Get.toNamed(AppRoutes.personalInformationScreen);
                        },
                        title: AppStrings.personalInformation.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.profile),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),
                      //===================> My friends list ListTile <=================
                      /*CustomListTile(
                        onTap: (){
                          Get.toNamed(AppRoutes.friendsListScreen);
                        },
                        title: AppStrings.myFriendsList.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.profile),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),*/
                      //===================> My Wallet ListTile <=================
                      CustomListTile(
                        onTap: (){
                          Get.toNamed(AppRoutes.myWalletScreen);
                        },
                        title: AppStrings.myWallet.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.myWallet),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),
                      //===================> All Song ListTile <=================
                      CustomListTile(
                        onTap: (){
                          Get.toNamed(AppRoutes.songListScreen);
                        },
                        title: 'All Song List'.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.mus, color: Colors.grey),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),
                      //===================> Setting ListTile <=================
                      CustomListTile(
                        onTap: (){
                          Get.toNamed(AppRoutes.settingsScreen);
                        },
                        title: AppStrings.setting.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.setting),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),
                      //===================> Logout ListTile <=================
                      CustomListTile(
                        onTap: (){
                          _showCustomBottomSheet(context);
                        },
                        title: AppStrings.logout.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.logout),
                        suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //===============================> Log Out Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: AppColors.cardColor,
          ),
          height: 265,
          padding: EdgeInsets.symmetric(horizontal:  16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5,),
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: 'Logout',
                fontWeight: FontWeight.w500,
                fontSize: 24.sp,
              ),
              SizedBox(
                width: 98.w,
                child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                  indent: 15.w,
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: 'Are you sure you want to log out?'.tr,
                fontSize: 16.sp,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      Get.back();
                    },
                    text: "No",
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () async {
                      await PrefsHelper.remove(AppConstants.isLogged);
                      await PrefsHelper.remove(AppConstants.userId);
                      await PrefsHelper.remove(AppConstants.bearerToken);
                      await PrefsHelper.remove(AppConstants.hasUpdateGallery);
                      Get.offAllNamed(AppRoutes.signInScreen);
                    },
                    text: "Yes",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
