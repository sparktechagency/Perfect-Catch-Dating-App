import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
import '../../../utils/app_colors.dart';
import '../../base/bottom_menu..dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});
  final TextEditingController _searchCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(3),
      appBar: AppBar(title: Text('Chats'.tr)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==========================> Search Bar <==========================
            CustomTextField(
              controller: _searchCTRL,
              hintText: AppStrings.search.tr,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16.h),
            //==========================> Your Match Section <==========================
            CustomText(
              text: AppStrings.yourMatch.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            Expanded(
              //flex: 1,
              child: ListView.builder(
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Column(
                      children: [
                        CustomNetworkImage(
                          imageUrl:
                          'https://img.freepik.com/free-photo/medium-shot-man-posing-indoors_23-2149438602.jpg?t=st=1745483014~exp=1745486614~hmac=c0fa59ea5ec97e9fe3107538064f3f58eba4716b83d95458b4cf8f458c544440&w=740',
                          height: 56.h,
                          width: 56.w,
                          boxShape: BoxShape.circle,
                        ),
                        CustomText(text: 'Ariyana'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            //==========================> Chats (recent) Section <==========================
            CustomText(
              text: AppStrings.chatsRecent.tr,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            //=============================> Chats List <====================================
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.messageScreen);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:
                              'https://img.freepik.com/free-photo/medium-shot-man-posing-indoors_23-2149438602.jpg?t=st=1745483014~exp=1745486614~hmac=c0fa59ea5ec97e9fe3107538064f3f58eba4716b83d95458b4cf8f458c544440&w=740',
                              height: 56.h,
                              width: 56.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //=====================> Name <=======================
                                  CustomText(
                                    text: 'Rida Anam',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    bottom: 6.h,
                                    maxLine: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  //=====================> Last Message <=======================
                                  CustomText(
                                    text: 'Hello, are you here?',
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            //==========================> Time and Unread Count Column <========================
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: '7:09 PM',
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomText(
                                    text: '99+',
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
