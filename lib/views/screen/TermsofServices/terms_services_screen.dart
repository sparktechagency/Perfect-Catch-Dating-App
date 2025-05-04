import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../../controllers/settings_controller.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_page_loading.dart';

class TermsServicesScreen extends StatelessWidget {
  TermsServicesScreen({super.key});
  final SettingController _settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    _settingController.getTermsCondition();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.termsConditions.tr),
      body: Obx(
        () =>
            _settingController.termContent.value.isEmpty
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
                            data: _settingController.termContent.value,
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
