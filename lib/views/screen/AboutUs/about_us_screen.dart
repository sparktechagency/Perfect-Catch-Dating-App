import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/settings_controller.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});
  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    _settingController.getAboutUs();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.aboutUs.tr),
      body: Obx(
        () =>
            _settingController.aboutContent.value.isEmpty
                ? Center(child: CustomText(text: 'No data found'))
                : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => Html(
                            shrinkWrap: true,
                            data: _settingController.aboutContent.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
