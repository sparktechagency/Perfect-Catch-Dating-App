import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_app_bar.dart';
import 'package:perfect_catch_dating_app/views/base/custom_list_tile.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.support.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.hello),
                SizedBox(height: 32.h),
                CustomListTile(
                  title: 'perfectcatchmanagment@gmail.com',
                  prefixIcon: SvgPicture.asset(AppIcons.mail),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
