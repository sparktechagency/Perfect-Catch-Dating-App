import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
   SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _authController = Get.put(AuthController());
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
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
              Center(child: CustomText(text: AppStrings.welcomeBack.tr, maxLine: 3)),
              //========================> Name Text Field <==================
              SizedBox(height: 32.h),
              CustomTextField(
                controller: _authController.nameCtrl,
                hintText: AppStrings.userName.tr,
              ),
              //========================> Email Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _authController.emailCtrl,
                hintText: AppStrings.email.tr,
              ),
              //========================> Phone Number Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _authController.phoneNumCtrl,
                keyboardType: TextInputType.number,
                hintText: AppStrings.phoneNumber.tr,
              ),
              //========================> Date Of Birth Day Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                onTab: (){
                  _authController.pickBirthDate(context);
                },
                readOnly: true,
                controller: _authController.dateOfBirthCtrl,
                hintText: AppStrings.dateOfBirth.tr,
                suffixIcons: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(AppIcons.calenderIcon),
                ),
              ),
              //========================> Password Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                isPassword: true,
                controller: _authController.passwordCtrl,
                hintText: AppStrings.password.tr,
              ),
              //========================> Confirm Password Text Field <==================
              SizedBox(height: 16.h),
              CustomTextField(
                isPassword: true,
                controller: _authController.confirmCtrl,
                hintText: AppStrings.confirmPassword.tr,
              ),
              SizedBox(height: 16.h),
              //=============================> Gender Selection <==============================
              CustomText(
                text: AppStrings.gender.tr,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              _genderRadioButton(),
              SizedBox(height: 16.h),
              //========================> Sign Up Button <==================
              CustomButton(onTap: () {}, text: AppStrings.signUp.tr),
              SizedBox(height: 32.h),
              //========================> Don’t have an account Sign In Button <==================
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
              SizedBox(height: 32.h)
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
           onTap: () => setState(() {
             _authController.selectedGender = 'male';
           }),
           child: Row(
             children: [
               Radio<String>(
                 value: 'male',
                 groupValue: _authController.selectedGender,
                 onChanged: (value) {
                   setState(() {
                     _authController.selectedGender = value;
                   });
                 },
                 fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                   if (states.contains(MaterialState.selected)) {
                     return AppColors.primaryColor;
                   }
                   return AppColors.primaryColor;
                 }),
               ),
               CustomText(
                 text: AppStrings.male.tr,
                 fontSize: 14.sp,
               ),
             ],
           ),
         ),
         InkWell(
           onTap: () => setState(() {
             _authController.selectedGender = 'female';
           }),
           child: Row(
             children: [
               Radio<String>(
                 value: 'female',
                 groupValue: _authController.selectedGender,
                 onChanged: (value) {
                   setState(() {
                     _authController.selectedGender = value;
                   });
                 },
                 fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                   if (states.contains(MaterialState.selected)) {
                     return AppColors.primaryColor;
                   }
                   return AppColors.primaryColor;
                 }),
               ),
               CustomText(
                 text: AppStrings.female.tr,
                 fontSize: 14.sp,
               ),
             ],
           ),
         ),
         InkWell(
           onTap: () => setState(() {
             _authController.selectedGender = 'non-binary';
           }),
           child: Row(
             children: [
               Radio<String>(
                 value: 'non-binary',
                 groupValue: _authController.selectedGender,
                 onChanged: (value) {
                   setState(() {
                     _authController.selectedGender = value;
                   });
                 },
                 fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                   if (states.contains(MaterialState.selected)) {
                     return AppColors.primaryColor;
                   }
                   return AppColors.primaryColor;
                 }),
               ),
               CustomText(
                 text: AppStrings.nonBinary.tr,
                 fontSize: 14.sp,
               ),
             ],
           ),
         ),
       ],
     );
   }
}
