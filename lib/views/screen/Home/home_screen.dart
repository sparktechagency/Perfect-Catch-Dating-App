import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
  final TCardController _cardController = TCardController();
  bool _allSwiped = false;
  final List<String> _images = [
    'https://s3-alpha-sig.figma.com/img/bd14/28fd/dd867a79c8e5d0ed1c4a5f67028adb22?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HmIV9lKO0iWwnSbWDoyYfyIoqBgcuNN2KslVE16~Bf9PHyPeWSBgikhqNPcEj1xPFyi3~MeLHQeVZ5U-Zji00Qv3Ea20bMqOIy25NB4AxguwYT8~ICsy5E8uZ18jdfttfm4B-6Bu2BE2Qd70gJaZ6BzkznhgfzgrH77fCQrT2XZBb-Ol7W15OY0h50Kp-w45ScdeB1vldAna0D3gl9273GddA0GKNEePL3l0bOwU74a5CCC4ZlDkZqzZtEKAkmznyp1tJQ50nJ9OFXuMA~oQyA7vu0Nx~j80nkkDIc3YyIq7JPkhLI~11gX1hIiOoBRMUhZ2VCRhBcXdtUk~q950hg__',
     'https://s3-alpha-sig.figma.com/img/bd14/28fd/dd867a79c8e5d0ed1c4a5f67028adb22?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HmIV9lKO0iWwnSbWDoyYfyIoqBgcuNN2KslVE16~Bf9PHyPeWSBgikhqNPcEj1xPFyi3~MeLHQeVZ5U-Zji00Qv3Ea20bMqOIy25NB4AxguwYT8~ICsy5E8uZ18jdfttfm4B-6Bu2BE2Qd70gJaZ6BzkznhgfzgrH77fCQrT2XZBb-Ol7W15OY0h50Kp-w45ScdeB1vldAna0D3gl9273GddA0GKNEePL3l0bOwU74a5CCC4ZlDkZqzZtEKAkmznyp1tJQ50nJ9OFXuMA~oQyA7vu0Nx~j80nkkDIc3YyIq7JPkhLI~11gX1hIiOoBRMUhZ2VCRhBcXdtUk~q950hg__',
    'https://s3-alpha-sig.figma.com/img/bd14/28fd/dd867a79c8e5d0ed1c4a5f67028adb22?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HmIV9lKO0iWwnSbWDoyYfyIoqBgcuNN2KslVE16~Bf9PHyPeWSBgikhqNPcEj1xPFyi3~MeLHQeVZ5U-Zji00Qv3Ea20bMqOIy25NB4AxguwYT8~ICsy5E8uZ18jdfttfm4B-6Bu2BE2Qd70gJaZ6BzkznhgfzgrH77fCQrT2XZBb-Ol7W15OY0h50Kp-w45ScdeB1vldAna0D3gl9273GddA0GKNEePL3l0bOwU74a5CCC4ZlDkZqzZtEKAkmznyp1tJQ50nJ9OFXuMA~oQyA7vu0Nx~j80nkkDIc3YyIq7JPkhLI~11gX1hIiOoBRMUhZ2VCRhBcXdtUk~q950hg__',
    'https://s3-alpha-sig.figma.com/img/bd14/28fd/dd867a79c8e5d0ed1c4a5f67028adb22?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=HmIV9lKO0iWwnSbWDoyYfyIoqBgcuNN2KslVE16~Bf9PHyPeWSBgikhqNPcEj1xPFyi3~MeLHQeVZ5U-Zji00Qv3Ea20bMqOIy25NB4AxguwYT8~ICsy5E8uZ18jdfttfm4B-6Bu2BE2Qd70gJaZ6BzkznhgfzgrH77fCQrT2XZBb-Ol7W15OY0h50Kp-w45ScdeB1vldAna0D3gl9273GddA0GKNEePL3l0bOwU74a5CCC4ZlDkZqzZtEKAkmznyp1tJQ50nJ9OFXuMA~oQyA7vu0Nx~j80nkkDIc3YyIq7JPkhLI~11gX1hIiOoBRMUhZ2VCRhBcXdtUk~q950hg__',
  ];

  void _onSwipe(SwipDirection direction, int index) {
    if (direction == SwipDirection.Left) {
      setState(() {});
      print('Disliked image ${index + 1}');
    } else if (direction == SwipDirection.Right) {
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
              onTap: () {},
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
                                  Get.toNamed(AppRoutes.userDetailsScreen);
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  height: 755.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: TCard(
                                          size: Size.infinite,
                                          controller: _cardController,
                                          cards:
                                              _images.asMap().entries.map((
                                                entry,
                                              ) {
                                                return Stack(
                                                  fit: StackFit.passthrough,
                                                  children: [
                                                    Card(
                                                      elevation: 8,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(16.r,),
                                                      ),
                                                      child: CustomNetworkImage(
                                                        imageUrl: entry.value,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topLeft: Radius.circular(16.r),
                                                              topRight: Radius.circular(16.r),
                                                            ),
                                                      ),
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
                                                                onTap: () {
                                                                  _onSwipe(
                                                                    SwipDirection.Right, entry.key,
                                                                  );
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
                                                                onTap: () {},
                                                                child: SvgPicture.asset(AppIcons.kiss),
                                                              ),
                                                              SizedBox(width: 8.w),
                                                              //====================> Care Button <=================
                                                              GestureDetector(
                                                                onTap: () {
                                                                  _onSwipe(SwipDirection.Right,entry.key);
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
                                                              borderRadius:
                                                                  BorderRadius.only(topLeft: Radius.circular(16.r),
                                                                    topRight: Radius.circular(16.r),
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  //==================> Name <===================
                                                                  CustomText(
                                                                    text: 'Kalvin, 23',
                                                                    fontSize: 32.sp,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white,
                                                                  ),
                                                                  //==================> Name <===================
                                                                  CustomText(
                                                                    text: 'Female',
                                                                    color: Colors.white,
                                                                    bottom: 6.h,
                                                                  ),
                                                                  //==================> Location Row <===================
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.location_on,
                                                                        color: Colors.white,
                                                                        size: 14.h,
                                                                      ),
                                                                      SizedBox(width: 4.w),
                                                                      CustomText(
                                                                        text: 'LOS Angeles • 20 kms away',
                                                                        color: Colors.white,
                                                                        maxLine: 3,
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
                                                  ],
                                                );
                                              }).toList(),
                                          onForward: (index, info) {
                                            _onSwipe(info.direction, index);
                                          },
                                          onEnd: () {
                                            setState(() {
                                              _allSwiped = true;
                                            });
                                            print(
                                              '====================> All cards swiped!',
                                            );
                                          },
                                        ),
                                      ),
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
