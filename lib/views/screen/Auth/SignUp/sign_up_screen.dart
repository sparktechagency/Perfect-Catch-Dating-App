import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _controller = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 64.h),
                Center(child: Image.asset(AppImages.appLogo)),
                SizedBox(height: 24.h),
                //========================> Sign up Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Sign Up '.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 70.w,
                          height: 8.h,
                          child: Divider(
                            thickness: 5.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: 'With Email'.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Sign up Sub Title <==================
                SizedBox(height: 14.h),
                Center(
                  child: CustomText(text: AppStrings.welcomeBack.tr, maxLine: 3),
                ),
                //========================> First Name Text Field <==================
                SizedBox(height: 32.h),
                CustomTextField(
                  controller: _controller.firstNameCtrl,
                  hintText: AppStrings.firstName.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name".tr;
                    }
                    return null;
                  },
                ),
                //========================> Last Name Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _controller.lastNameCtrl,
                  hintText: AppStrings.lastName.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name".tr;
                    }
                    return null;
                  },
                ),
                //========================> Email Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _controller.emailCtrl,
                  hintText: AppStrings.email.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email".tr;
                    }
                    return null;
                  },
                ),
                //========================> Phone Number Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _controller.phoneNumCtrl,
                  keyboardType: TextInputType.number,
                  hintText: AppStrings.phoneNumber.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number".tr;
                    }
                    return null;
                  },
                ),
                //========================> Date Of Birth Day Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  onTab: () {
                    _controller.pickBirthDate(context);
                  },
                  readOnly: true,
                  controller: _controller.dateOfBirthCtrl,
                  hintText: AppStrings.dateOfBirth.tr,
                  suffixIcons: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SvgPicture.asset(AppIcons.calenderIcon),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select your birth date".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=============================> Gender Selection <==============================
                CustomText(
                  text: AppStrings.gender.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                _genderRadioButton(),
                //========================> Password Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  isPassword: true,
                  controller: _controller.passwordCtrl,
                  hintText: AppStrings.password.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    return null;
                  },
                ),
                //========================> Confirm Password Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  isPassword: true,
                  controller: _controller.confirmCtrl,
                  hintText: AppStrings.confirmPassword.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password".tr;
                    }
                    else if(_controller.passwordCtrl.text != _controller.confirmCtrl.text){
                      return "Password doesn't match".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _checkboxSection(),
                SizedBox(height: 16.h),
                //========================> Sign Up Button <==================
                Obx(()=> CustomButton(
                    loading: _controller.signUpLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked ) {
                          _controller.handleSignUp();
                        }
                        else {
                          Fluttertoast.showToast(
                              msg: 'Please accept Terms & Conditions'.tr);
                        }
                      }
                    },
                    text: AppStrings.signUp.tr,
                  ),
                ),
                SizedBox(height: 16.h),
                //========================> Already have an account Sign In Button <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppStrings.alreadyHaveAccount.tr),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signIn.tr,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            ),
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

  //==========================> Checkbox Section Widget <=======================
  _checkboxSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          side: BorderSide(
            color: isChecked ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        Text.rich(
          maxLines: 2,
          TextSpan(
            text: AppStrings.byCreatingAnAccount.tr,
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: AppStrings.termsConditions.tr,
                style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.bold),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        //Get.toNamed(AppRoutes.termsConditionScreen);
                      },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: AppStrings.privacyPolicy.tr,
                style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.bold),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        //Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
