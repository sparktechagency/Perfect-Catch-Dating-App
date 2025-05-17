import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_catch_dating_app/controllers/profile_controller.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
import '../../../../helpers/time_formate.dart';
import '../../../../service/api_constants.dart';
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
  var parameter = Get.parameters;

 /* final List<String> interests = [
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
  ].obs;
*/

  @override
  void initState() {
    super.initState();
    _controller.firstNameCTRL.text = Get.parameters['firstName'] ?? '';
    _controller.lastNameCTRL.text = Get.parameters['lastName'] ?? '';
    _controller.phoneCTRL.text = Get.parameters['phoneNumber'] ?? '';
    _controller.dateBirthCTRL.text = Get.parameters['dateOfBirth'] ?? '';

    String? dob = Get.parameters['dateOfBirth'];
    if (dob != null && dob.isNotEmpty) {
      try {
        _controller.dateBirthCTRL.text = TimeFormatHelper.formatDates(dob);
      } catch (e) {
        print("Error formatting date: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: Obx(()=> SingleChildScrollView(
          child: Column(
            children: [
              //==============================> Profile picture section <=======================
              Stack(
                children: [
                  _controller.profileImagePath.value.isNotEmpty
                      ? Container(
                    width: 402.w,
                    height: 369.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                            image: FileImage(File(_controller.profileImagePath.value)),
                            fit: BoxFit.cover)))
                      : CustomNetworkImage(
                    imageUrl:
                    '${ApiConstants.imageBaseUrl}${_controller.profileModel.value.profileImage}',
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
                        //_controller.pickImage(ImageSource.gallery);
                        _showImagePickerOption();
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
                        //====================> First Name Text Field <================
                        CustomTextField(
                          controller: _controller.firstNameCTRL,
                          hintText: AppStrings.firstName.tr,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SvgPicture.asset(AppIcons.profile),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        //====================> First Name Text Field <================
                        CustomTextField(
                          controller: _controller.lastNameCTRL,
                          hintText: AppStrings.lastName.tr,
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
                        //====================> Date Birth Text Field <================
                        CustomTextField(
                          onTab: ()=>_controller.pickBirthDate(context),
                          readOnly: true,
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
                        // CustomTextField(
                        //   controller: _controller.locationCTRL,
                        //   hintText: AppStrings.location.tr,
                        //   prefixIcon: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 16.w),
                        //     child: SvgPicture.asset(
                        //       AppIcons.location,
                        //       color: Colors.grey,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 16.h),
                        //====================> Height Text Field <================
                        CustomTextField(
                          onTab: ()=>_controller.pickHeight(context),
                          readOnly: true,
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
                        //====================> Weight Text Field <================
                        CustomTextField(
                          onTab: ()=>_controller.pickWeight(context),
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller: _controller.weightCTRL,
                          hintText: AppStrings.weight.tr,
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
                          onTab: ()=>_controller.pickMaritalStatus(context),
                          readOnly: true,
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
                          onTab: ()=>_controller.pickReligion(context),
                          readOnly: true,
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
                          onTab: ()=>_controller.pickEducation(context),
                          readOnly: true,
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
                                      onTap: () {
                                        // _showInterestsDialog(context);
                                      },
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
                                  children: _controller.selectedInterest.map((interest) {
                                    return _interestChip(interest);
                                  }).toList(),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: AppStrings.language.tr,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _controller.pickCountries(context);
                                      },
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
                                  children: _controller.selectedLanguage.map((language) {
                                    return _languageChip(language);
                                  }).toList(),
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
                child: Obx(()=> CustomButton(
                      loading: _controller.updateProfileLoading.value,
                      onTap: (){
                        _controller.updateProfile();
                      },
                      text: AppStrings.updateProfile.tr),
                ),
              ),
              SizedBox(height: 22.h),

            ],
          ),
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
                _controller.selectedGender = 'other';
              }),
          child: Row(
            children: [
              Radio<String>(
                value: 'other',
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
              CustomText(text: AppStrings.other.tr, fontSize: 14.sp),
            ],
          ),
        ),
      ],
    );
  }

  //=========================> Interest Chip <================
  Widget _interestChip(String interest) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [CustomText(text: interest, color: Colors.white)],
      ),
      backgroundColor: AppColors.primaryColor,
      deleteIcon: Icon(Icons.cancel, size: 16, color: Colors.white),
      onDeleted: () {
        _controller.selectedInterest.remove(interest);
      },
    );
  }
  //=========================> Language Chip <================
  Widget _languageChip(String language) {
    return Chip(
      backgroundColor: Color(0xFF00A4A9),
      labelStyle: TextStyle(color: Colors.white),
      label: Text(language),
      onDeleted: () {
        _controller.selectedLanguage.remove(language);
      },
    );
  }


  //====================================> Pick Image Gallery and Camera <====================
  void _showImagePickerOption() {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              //=========================> Pick Image Gallery <==================
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _controller.pickImage(ImageSource.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Gallery',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
              //=========================> Pick Image Camera <====================
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _controller.pickImage(ImageSource.camera);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Camera',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  //====================================> Show Interests Dialog <====================
/*
  void _showInterestsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'Select Interests',  // Title for the dialog
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(()=> Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: interests.map((interest) {
                    return ChoiceChip(
                      showCheckmark: false,
                      label: CustomText(
                        text: interest.toLowerCase(),
                        color: _controller.selectedInterest.contains(interest)
                            ? Colors.white
                            : Colors.black,
                      ),
                      side: BorderSide(
                        width: 1.w,
                        color: AppColors.primaryColor
                      ),
                      selected: _controller.selectedInterest.contains(interest.toLowerCase()),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            _controller.selectedInterest.add(interest.toLowerCase());
                          } else {
                            _controller.selectedInterest.remove(interest);
                          }
                        });
                      },
                      selectedColor: AppColors.primaryColor,
                      backgroundColor: Colors.white,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                print('Selected interests: ${_controller.selectedInterest}');
              },
              child: CustomText(text: 'Done'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(text: 'Cancel'),
            ),
          ],
        );
      },
    );
  }

*/

  //====================================> ShowLanguageDialog <====================
  void _showLanguageDialog(BuildContext context) {
    TextEditingController languageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Add New Language', fontSize: 16.sp,fontWeight: FontWeight.bold),
          content: TextField(
            controller: languageController,
            decoration: InputDecoration(hintText: 'Enter language name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String newLanguage = languageController.text.trim();
                if (newLanguage.isNotEmpty) {
                  _controller.selectedLanguage.add(newLanguage);
                  Navigator.pop(context);
                  print('=============> ${_controller.selectedLanguage}');
                }
              },
              child: CustomText(text: 'Add'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(text: 'Cancel'),
            ),
          ],
        );
      },
    );
  }
}
