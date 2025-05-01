import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
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
                //========================> Forgot Password Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Forgot '.tr,
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
                      text: 'Password'.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Forgot Password Sub Title <==================
                SizedBox(height: 14.h),
                CustomText(
                  text: AppStrings.pleaseEnterYourEmail.tr,
                  maxLine: 3,
                ),
                //========================> Email Text Field <==================
                SizedBox(height: 32.h),
                CustomTextField(
                  controller: _controller.forgetEmailTextCtrl,
                  hintText: AppStrings.email.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                //========================> Send OTP Button <==================
                Obx(
                  () => CustomButton(
                    loading: _controller.forgotLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.handleForget();
                      }
                    },
                    text: AppStrings.sendOTP.tr,
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
