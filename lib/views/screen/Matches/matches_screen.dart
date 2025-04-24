import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
import '../../base/bottom_menu..dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({Key? key}) : super(key: key);

  final TextEditingController _searchCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomMenu(1),
      appBar: AppBar(title: CustomText(text: AppStrings.matches.tr, fontSize: 16.sp, fontWeight: FontWeight.w600)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              //========================> Search Bar <========================
              CustomTextField(
                controller: _searchCTRL,
                hintText: AppStrings.search.tr,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 16.h),
              //=======================> Grid of User Cards <====================
              SizedBox(
                height: 632.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.userDetailsScreen);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background Image
                          CustomNetworkImage(
                            imageUrl:
                            'https://img.freepik.com/free-photo/medium-shot-guy-with-crossed-arms_23-2148227939.jpg?ga=GA1.1.1702237683.1725447794&semt=ais_hybrid&w=740',
                            height: 127.h,
                            width: 173.w,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text: 'Leilani, 19',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.messageScreen);
                                          },
                                          child: SvgPicture.asset(AppIcons.msg),
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      text: 'Dhaka Bangladesh',
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
