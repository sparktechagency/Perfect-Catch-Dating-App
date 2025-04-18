import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_catch_dating_app/controllers/profile_controller.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //==============================> Profile picture section <=======================
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl:
                      'https://s3-alpha-sig.figma.com/img/aba5/7875/06b6763c27225f414df7f949639fd20d?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=BIM9NpRoedGzbRmOCOQwiVNR5~KnNHQyU-~zHD-zQ6niilUr5LM73jnCiN8Gii6tQL~UNbROSw4ojYsBWp6PBzymehTvt~3qZoXlGoIHavo7uIxXMKyK3Vxv~4Kls0MRboaDlqlZWbyTVGQzXuf~T08jG~Rvm5iPK8WATnHVZ-WmE5m0Ysf9eklTkd3JPZd4jyaA6W1twcCM6H2erKBSI0F~SroPsU3JRjet9LxsAIfT1FERORU~z~9MSbXzLWSB-ms98Ns2Ey0YYuSi1ceWrW~oCW9ASwMmYx~LQMJGCjJPfHHRCBVRGx3azfGrtqmxBbasTwGuKx~rHG8wUAIUAw__',
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
                      _controller.pickImage(ImageSource.gallery);
                    },
                    child: SvgPicture.asset(AppIcons.gallery),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            //==============================> Container Text Field <=======================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //====================> User Name Text Field <================
                      CustomTextField(
                        controller: _controller.userNameCTRL,
                        hintText: AppStrings.userName.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(AppIcons.profile),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Phone Number Text Field <================
                      CustomTextField(
                        controller: _controller.phoneCTRL,
                        hintText: AppStrings.phoneNumber.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.call,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Phone Number Text Field <================
                      CustomTextField(
                        controller: _controller.dateBirthCTRL,
                        hintText: AppStrings.dateOfBirth.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.calenderIcon,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Location Text Field <================
                      CustomTextField(
                        controller: _controller.locationCTRL,
                        hintText: AppStrings.location.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.location,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Age Text Field <================
                      CustomTextField(
                        controller: _controller.ageCTRL,
                        hintText: AppStrings.age.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.age,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Height Text Field <================
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: _controller.heightCTRL,
                        hintText: AppStrings.height.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.age,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Marital Status Text Field <================
                      CustomTextField(
                        controller: _controller.marriedCTRL,
                        hintText: AppStrings.maritalStatus.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.age,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Religion Text Field <================
                      CustomTextField(
                        controller: _controller.religionCTRL,
                        hintText: AppStrings.religion.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.religion,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Education qualification Text Field <================
                      CustomTextField(
                        controller: _controller.eduCTRL,
                        hintText: AppStrings.education.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(
                            AppIcons.edu,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //=======================> Gender Selection <=====================
                      CustomText(
                        text: AppStrings.gender.tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      _genderRadioButton(),
                      SizedBox(height: 8.h),
                      //====================> Interest Container <================
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: AppStrings.addYourFavoriteInterest.tr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.add_box_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 0.4, color: Colors.grey),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Wrap(
                                spacing: 8.0,
                                children: [
                                  _interestChip('Reading'),
                                  _interestChip('Music'),
                                  _interestChip('Sports'),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> Language Container <================
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: AppStrings.language.tr,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.add_box_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 0.4, color: Colors.grey),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Wrap(
                                spacing: 8.0,
                                children: [
                                  _languageChip('English'),
                                  _languageChip('Bangla'),
                                  _languageChip('Hinde'),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //====================> About Text Field <================
                      CustomText(
                        text: AppStrings.about.tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        bottom: 16.h,
                      ),
                      CustomTextField(
                        controller: _controller.aboutCTRL,
                        hintText: 'Write about your self...',
                        maxLines: 5,
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            //==============================> Update profile Button <=======================
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomButton(onTap: (){}, text: AppStrings.updateProfile.tr),
            ),
            SizedBox(height: 22.h),

          ],
        ),
      ),
    );
  }

  //=========================> Gender Radio Button <================
  _genderRadioButton() {
    return Row(
      children: [
        InkWell(
          onTap:
              () => setState(() {
                _controller.selectedGender = 'male';
              }),
          child: Row(
            children: [
              Radio<String>(
                value: 'male',
                groupValue: _controller.selectedGender,
                onChanged: (value) {
                  setState(() {
                    _controller.selectedGender = value;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return AppColors.primaryColor;
                }),
              ),
              CustomText(text: AppStrings.male.tr, fontSize: 14.sp),
            ],
          ),
        ),
        InkWell(
          onTap:
              () => setState(() {
                _controller.selectedGender = 'female';
              }),
          child: Row(
            children: [
              Radio<String>(
                value: 'female',
                groupValue: _controller.selectedGender,
                onChanged: (value) {
                  setState(() {
                    _controller.selectedGender = value;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return AppColors.primaryColor;
                }),
              ),
              CustomText(text: AppStrings.female.tr, fontSize: 14.sp),
            ],
          ),
        ),
        InkWell(
          onTap:
              () => setState(() {
                _controller.selectedGender = 'non-binary';
              }),
          child: Row(
            children: [
              Radio<String>(
                value: 'non-binary',
                groupValue: _controller.selectedGender,
                onChanged: (value) {
                  setState(() {
                    _controller.selectedGender = value;
                  });
                },
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return AppColors.primaryColor;
                }),
              ),
              CustomText(text: AppStrings.nonBinary.tr, fontSize: 14.sp),
            ],
          ),
        ),
      ],
    );
  }

  //=========================> Interest Chip <================
  _interestChip(String label) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [CustomText(text: label, color: Colors.white)],
      ),
      backgroundColor: AppColors.primaryColor,
      deleteIcon: Icon(Icons.cancel, size: 16, color: Colors.white),
      onDeleted: () {},
    );
  }

  Widget _languageChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Color(0xFF00A4A9),
      labelStyle: TextStyle(color: Colors.white),
      deleteIcon: Icon(Icons.cancel, size: 16, color: Colors.white),
      onDeleted: () {},
    );
  }
}
