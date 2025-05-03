import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/match_controller.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/models/matches_model.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_page_loading.dart';

class MatchesScreen extends StatefulWidget {
  MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController _searchCTRL = TextEditingController();
  final MatchController _matchController = Get.put(MatchController());

  //======================> Method to calculate age from the date of birth <========================
  int calculateAge(MatchesModel user) {
    final dateOfBirth = user.dateOfBirth;
    if (dateOfBirth == null) {
      return 0;
    }
    DateTime dob = dateOfBirth;
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
    _matchController.getMatchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomMenu(1),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.matches.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Obx(() {
        //===================> Check if loading data or matchModel is empty <===========================
        if (_matchController.matchLoading.value) {
          return const Center(child: CustomPageLoading());
        } else if (_matchController.matchesModel.isEmpty) {
          return Center(child: CustomText(text: 'No matches found'.tr));
        }
        return SingleChildScrollView(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: _matchController.matchesModel.length,
                    itemBuilder: (context, index) {
                      final MatchesModel user = _matchController.matchesModel[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.userDetailsScreen,
                            parameters: {
                              'profileId': '${user.id}',
                              'age': '${calculateAge(user)}',
                            },
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Background Image
                            CustomNetworkImage(
                              imageUrl:
                                  '${ApiConstants.imageBaseUrl}${user.profileImage}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomText(
                                            text: '${user.fullName}',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                          ),
                                          CustomText(
                                            text: ', ${user.age}',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            maxLine: 2,
                                            textAlign: TextAlign.start,
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.messageScreen,
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              AppIcons.msg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: '${user.location}',
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
        );
      }),
    );
  }
}
