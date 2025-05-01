import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController _controller = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.changePassword.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                //==========================> Current password Text Field <===================
                CustomTextField(
                  isPassword: true,
                  controller: _controller.currentPasswordCtrl,
                  hintText: AppStrings.oldPassword.tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter current password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //==========================> New password Text Field <===================
                CustomTextField(
                  isPassword: true,
                  controller: _controller.newPasswordCtrl,
                  hintText: AppStrings.newPassword.tr,
                  validator: (value) {
                    if (value == null) {
                      return "Please set new password";
                    } else if (value.length < 8 || !_validatePassword(value)) {
                      return "Password: 8 characters min, letters & digits \nrequired";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //==========================> Confirm Password Text Field <===================
                CustomTextField(
                  isPassword: true,
                  controller: _controller.confirmPassController,
                  hintText: AppStrings.confirmPassword.tr,
                  validator: (value) {
                    if (value == null) {
                      return "Please re-enter new password";
                    } else if (value != _controller.newPasswordCtrl.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 268.h),
                //==========================> Update Password Button <=======================
                Obx(
                  () => CustomButton(
                    loading: _controller.changePassLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.handleChangePassword(
                          _controller.currentPasswordCtrl.text,
                          _controller.newPasswordCtrl.text,
                        );
                      }
                    },
                    text: AppStrings.updatePassword.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}
