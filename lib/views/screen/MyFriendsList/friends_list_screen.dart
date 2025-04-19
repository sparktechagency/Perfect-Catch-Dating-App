import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';

import '../../base/custom_text.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({super.key});

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // All friends data
  final List<Map<String, String>> friends = [
    {'name': 'Leilani', 'location': 'Chicago, IL United States'},
    {'name': 'Jamal', 'location': 'Atlanta, GA United States'},
    {'name': 'Sofia', 'location': 'United States'},
    {'name': 'Raj', 'location': 'New York'},
    {'name': 'Ana', 'location': 'Miami, FL United States'},
    {'name': 'Liam', 'location': 'WA United States'},
    {'name': 'Sofia', 'location': 'United States'},
    {'name': 'Raj', 'location': 'New York'},
  ];

  // Block friends data
  final List<Map<String, String>> blockFriends = [
    {'name': 'Leilani', 'location': 'Chicago, IL United States'},
    {'name': 'Jamal', 'location': 'Atlanta, GA United States'},
    {'name': 'Sofia', 'location': 'United States'},
    {'name': 'Raj', 'location': 'New York'},
    {'name': 'Ana', 'location': 'Miami, FL United States'},
    {'name': 'Liam', 'location': 'WA United States'},
    {'name': 'Sofia', 'location': 'United States'},
    {'name': 'Raj', 'location': 'New York'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Friends List'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 48.w),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
             // border: Border.all(color: AppColors.primaryColor, width: 1.w),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'All Friends'.tr,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Block List'.tr,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //=============================> All Friends Tab <====================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Card(
              color: Colors.white,
              elevation: 5.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:
                                  'https://s3-alpha-sig.figma.com/img/20b7/e70a/39319e91a805caf2e295a730292e5ce3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=C7VJmVE0zslKEw0tG5FsFxeFVZBJ96eK7Dlo6lJWdDAUaOMm7A9Ady9DmhI67KXJxXweLUxJKz5ZbLyS1drBwAob8hoPtQ1v~H4m-PK52dQFX1FDSxY5d4-wm6Mg7UHxOcPVH0mQqYrM~Y0cHSQDFME~bBJMq2OYDWTnjGvotBhrMen94IPEiF3XMEotObtlHPZ4kcBI~oiVV90n0TKXEQHYgB1Hzl4n97U~uHn1AtbbQPsBLJaucFuvxYhyJo26aMi8iY8cVXN-TGlE5iw7QqQpXnKy01HsLMyhCrUYne5fnDbjr3w2E5ZByu4PkA3B0lybq4ZXyTQaPu4TPUorNw__',
                              height: 72.h,
                              width: 72.w,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: friends[index]['name']!),
                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: friends[index]['location']!,
                                    maxLine: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            CustomButton(
                              onTap: () {
                                Get.toNamed(AppRoutes.userDetailsScreen);
                              },
                              text: AppStrings.view.tr,
                              fontSize: 10.sp,
                              width: 66.w,
                              height: 27.h,
                            ),
                          ],
                        ),
                        Divider(thickness: 1.5, color: Colors.grey.shade200),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          //============================> Block List Tab <=======================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Card(
              color: Colors.white,
              elevation: 5.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blockFriends.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:
                                  'https://s3-alpha-sig.figma.com/img/20b7/e70a/39319e91a805caf2e295a730292e5ce3?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=C7VJmVE0zslKEw0tG5FsFxeFVZBJ96eK7Dlo6lJWdDAUaOMm7A9Ady9DmhI67KXJxXweLUxJKz5ZbLyS1drBwAob8hoPtQ1v~H4m-PK52dQFX1FDSxY5d4-wm6Mg7UHxOcPVH0mQqYrM~Y0cHSQDFME~bBJMq2OYDWTnjGvotBhrMen94IPEiF3XMEotObtlHPZ4kcBI~oiVV90n0TKXEQHYgB1Hzl4n97U~uHn1AtbbQPsBLJaucFuvxYhyJo26aMi8iY8cVXN-TGlE5iw7QqQpXnKy01HsLMyhCrUYne5fnDbjr3w2E5ZByu4PkA3B0lybq4ZXyTQaPu4TPUorNw__',
                              height: 72.h,
                              width: 72.w,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: blockFriends[index]['name']!,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: blockFriends[index]['location']!,
                                    maxLine: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            CustomButton(
                              onTap: () {},
                              text: AppStrings.unblock.tr,
                              fontSize: 10.sp,
                              width: 66.w,
                              height: 27.h,
                            ),
                          ],
                        ),
                        Divider(thickness: 1.5, color: Colors.grey.shade200),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
