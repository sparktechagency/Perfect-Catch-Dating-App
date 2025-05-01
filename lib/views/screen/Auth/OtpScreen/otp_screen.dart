import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/views/base/custom_pin_code_text_field.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController _authController = Get.put(AuthController());
  var parameters = Get.parameters;

  int _start = 180;
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  startTimer() {
    print("Start Time$_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isResetPassword = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    if (Get.arguments != null && Get.arguments['isPassreset'] != null) {
      getResetPass();
    }
  }

  getResetPass() {
    var isResetPass = Get.arguments['isPassreset'];
    if (isResetPass) {
      isResetPassword = isResetPass;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
              //========================> Verify Email Title <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Verify '.tr,
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
                    text: 'Email'.tr,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 6.h,
                  ),
                ],
              ),
              //========================> Verify Email Sub Title <==================
              SizedBox(height: 14.h),
              CustomText(text: AppStrings.pleaseEnterCheckEmail.tr, maxLine: 3),
              //========================> Email Text Field <==================
              SizedBox(height: 32.h),
              CustomPinCodeTextField(
                textEditingController: _authController.otpCtrl,
              ),
              SizedBox(height: 16.h),
              //========================> Timer Field <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.clock),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: '$timerText sc',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              //========================> Verify Email Button <==================
              Obx(()=> CustomButton(
                  loading: _authController.otpLoading.value,
                    onTap: () {
                  _authController.handleOtpVery(email: "${parameters["email"]}",
                      otp: _authController.otpCtrl.text,
                      screenType: "${parameters["screenType"]}");
                }, text: AppStrings.verifyEmail.tr),
              ),
              SizedBox(height: 32.h),
              //========================> Didn’t receive code Resend it Button <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppStrings.didnotReceiveCode.tr),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: () {
                      _authController.resendOtp("${parameters["email"]}");
                      _authController.otpCtrl.clear();
                    },
                    child: CustomText(
                      text: AppStrings.resendCode.tr,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
