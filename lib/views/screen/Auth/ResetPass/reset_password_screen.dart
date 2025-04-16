import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController passCTRL = TextEditingController();
  final TextEditingController confirmPassCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 164.h),
              Center(child: Image.asset(AppImages.appLogo)),
              SizedBox(height: 24.h),
              //========================> Reset Password Title <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Reset '.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 56.w,
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
              //========================> Reset Password Sub Title <==================
              SizedBox(height: 14.h),
              CustomText(text: AppStrings.enterNewPassword.tr, maxLine: 3),
              //========================> Password Text Field <==================
              SizedBox(height: 32.h),
              CustomTextField(
                isPassword: true,
                controller: passCTRL,
                hintText: AppStrings.password.tr,
              ),
              //========================> Confirm Password Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                isPassword: true,
                controller: confirmPassCTRL,
                hintText: AppStrings.confirmPassword.tr,
              ),
              SizedBox(height: 32.h),
              //========================> Reset Password Button <==================
              CustomButton(onTap: () {
                Get.toNamed(AppRoutes.yourInterestsScreen);
              }, text: AppStrings.resetPassword.tr),
            ],
          ),
        ),
      ),
    );
  }
}
