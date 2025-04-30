import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/auth_controller.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';

import '../../../../utils/app_images.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final AuthController _controller = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 164.h),
                Center(child: Image.asset(AppImages.appLogo)),
                SizedBox(height: 24.h),
                //========================> Sign In Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Sign In '.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 65.w,
                          height: 8.h,
                          child: Divider(
                            thickness: 5.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: 'To Your Account'.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Sign In Sub Title <==================
                SizedBox(height: 14.h),
                CustomText(text: AppStrings.welcomeSignIn.tr, maxLine: 3),
                //========================> Email Text Field <==================
                SizedBox(height: 32.h),
                CustomTextField(
                  controller: _controller.signInEmailCtrl,
                  hintText: AppStrings.email.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email".tr;
                    }
                    return null;
                  },
                ),
                //========================> Password Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  isPassword: true,
                  controller: _controller.signInPassCtrl,
                  hintText: AppStrings.password.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    return null;
                  },
                ),
                //========================> Forgot Passwords Button <==================
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: CustomText(
                      text: AppStrings.forgotPasswords.tr,
                      fontWeight: FontWeight.w500,
                      bottom: 32.h,
                    ),
                  ),
                ),
                //========================> Sign in Button <==================
                CustomButton(
                  loading: _controller.signInLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                          _controller.handleSignIn();
                      }
                }, text: AppStrings.signIn.tr),
                SizedBox(height: 32.h),
                //========================> Don’t have an account Sign Up Button <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppStrings.donotHaveAccount.tr),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signUpScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signUp.tr,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
