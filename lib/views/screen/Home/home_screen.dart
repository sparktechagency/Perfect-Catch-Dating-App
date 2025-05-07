import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/home_controller.dart';
import 'package:perfect_catch_dating_app/models/user_model.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/style.dart';
import 'package:tcard/tcard.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getAllUsersProfiles();
  }

  final TCardController _cardController = TCardController();
  bool _allSwiped = false;
  final List<String> _images = [
    'https://img.freepik.com/free-photo/medium-shot-guy-with-crossed-arms_23-2148227939.jpg?ga=GA1.1.1702237683.1725447794&semt=ais_hybrid&w=740',
    'https://img.freepik.com/free-photo/medium-shot-guy-with-crossed-arms_23-2148227939.jpg?ga=GA1.1.1702237683.1725447794&semt=ais_hybrid&w=740',
    'https://img.freepik.com/free-photo/medium-shot-guy-with-crossed-arms_23-2148227939.jpg?ga=GA1.1.1702237683.1725447794&semt=ais_hybrid&w=740',
    'https://img.freepik.com/free-photo/medium-shot-guy-with-crossed-arms_23-2148227939.jpg?ga=GA1.1.1702237683.1725447794&semt=ais_hybrid&w=740',
  ];

  void _onSwipe(SwipDirection direction, int index) {
    debugPrint(direction.toString());
    if (direction == SwipDirection.Left) {
      _cardController.forward(direction: direction);
      setState(() {});

      print('Disliked image ${index + 1}');
    } else if (direction == SwipDirection.Right) {
      _cardController.forward(direction: direction);

      setState(() {});
      print('Liked image ${index + 1}');
    }

    if (index == _images.length - 0) {
      setState(() {
        _allSwiped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppImages.appLogo, width: 76.w, height: 64.h),
            Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.filterScreen);
              },
              child: SvgPicture.asset(
                AppIcons.filter,
                width: 32.w,
                height: 32.h,
              ),
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationsScreen);
              },
              child: SvgPicture.asset(
                AppIcons.notification,
                width: 32.w,
                height: 32.h,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _allSwiped
                        ? Center(
                          child: CustomText(
                            text: "No One Available",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        )
                        : Column(
                          children: [
                            //==============================> Tinder Swipe Section <=================
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.userDetailsScreen, arguments: user);
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  height: 680.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Obx(() {
                                        if (homeController.isProfilesLoading.value) {
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        final userList = homeController.usersList;

                                        if (userList.isEmpty) {
                                          return Column(
                                            children: [
                                              Expanded(child: Center(child: Text("No User Found", style: AppStyles.h3()))),
                                            ],
                                          );
                                        }
                                        return  Expanded(
                                          child: TCard(
                                            size: const Size(double.infinity, double.infinity),
                                            controller: _cardController,
                                            cards: List.generate(homeController.usersList.length, (index) {
                                              final UserModel user = homeController.usersList[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  Get.toNamed(AppRoutes.userDetailsScreen, arguments: user.id);
                                                },
                                                child: Stack(
                                                  fit: StackFit.passthrough,
                                                  children: [
                                                    Card(
                                                        elevation: 8,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(16.r,),
                                                        ),
                                                        child: CustomNetworkImage(
                                                            imageUrl: "${ApiConstants.imageBaseUrl}${user.profileImage}",
                                                            height: double.infinity,
                                                            width: double.infinity,
                                                            borderRadius: BorderRadius.circular(16.r)
                                                        )
                                                    ),
                                                    //===========================> Name and Role Positioned <===================
                                                    Positioned(
                                                      bottom: 3.h,
                                                      left: 3.w,
                                                      right: 3.w,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              //====================> BrokenHeart Button <=================
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  await homeController.userReaction(profileId: '${user.id}', reaction: "cupid", matchesProfileId: '${user.id}', matchesUserProfile: '${user.profileImage}' );
                                                                  _onSwipe(SwipDirection.Left, index);
                                                                },
                                                                child: SvgPicture.asset(
                                                                  AppIcons
                                                                      .brokenHeart,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              //====================> Kiss Button <=================
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  await homeController.userReaction(profileId: '${user.id}', reaction: "kiss", matchesProfileId: '${user.id}', matchesUserProfile: '${user.profileImage}');
                                                                  _onSwipe(SwipDirection.Right, index);
                                                                },
                                                                child: SvgPicture.asset(AppIcons.kiss),
                                                              ),
                                                              SizedBox(width: 8.w),
                                                              //====================> Care Button <=================
                                                              GestureDetector(
                                                                onTap: () async{
                                                                  await homeController.userReaction(profileId: '${user.id}', reaction: "hug", matchesProfileId: '${user.id}', matchesUserProfile: '${user.profileImage}');
                                                                  _onSwipe(SwipDirection.Left, index);
                                                                },
                                                                child:
                                                                SvgPicture.asset(AppIcons.care),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8.h),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.black.withOpacity(0.3),
                                                                borderRadius: BorderRadius.circular(16.r)
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //==================> Name <===================
                                                                  CustomText(
                                                                    text: '${user.fullName}',
                                                                    fontSize: 32.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white,
                                                                  ),
                                                                  //==================> Name <===================
                                                                  //TODO Gender is not found
                                                                  // CustomText(
                                                                  //   text: user.,
                                                                  //   color: Colors.white,
                                                                  //   bottom: 6.h,
                                                                  // ),
                                                                  //==================> Location Row <===================
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.location_on,
                                                                        color: Colors.white,
                                                                        size: 14.h,
                                                                      ),
                                                                      SizedBox(width: 4.w),
                                                                      CustomText(
                                                                        text: '${user.location!.locationName} • ${user.setDistance} kms away',
                                                                        color: Colors.white,
                                                                        maxLine: 3,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 16.h,)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            onForward: (index, info) {
                                              _onSwipe(info.direction, index);
                                            },
                                            onEnd: () {
                                              setState(() {
                                                _allSwiped = true;
                                              });
                                            },
                                          ),
                                        );
                                      })

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
