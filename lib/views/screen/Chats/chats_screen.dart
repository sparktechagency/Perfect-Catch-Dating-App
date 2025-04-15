import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
              flex: 1,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 38.r,
                          backgroundImage: AssetImage(AppImages.music),
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
            SizedBox(height: 16.h),
            //=============================> Chats List <====================================
            Expanded(
              flex: 3,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.messageScreen);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          CircleAvatar(
                            radius: 42.r,
                            backgroundImage: AssetImage(AppImages.music),
                          ),
                          SizedBox(width: 12.w),
                          //==========================> Chat Details <=========================
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CustomText(
                                        text: 'Ariana',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        maxLine: 2,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    //==========================> Time and Unread Count Column <========================
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: '7:09 PM',
                                          fontSize: 12.sp,
                                          color: Colors.grey,
                                        ),
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
                                CustomText(
                                  text: 'Hey Bro, Do You Want To Play...',
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
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
