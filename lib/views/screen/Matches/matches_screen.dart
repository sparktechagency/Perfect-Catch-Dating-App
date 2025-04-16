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
      appBar: AppBar(title: CustomText(text: AppStrings.matches.tr)),
      body: Padding(
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
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: 10,
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
                              'https://s3-alpha-sig.figma.com/img/157d/4a30/1e58f95239747f129212af44c3ef45b0?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=azoXeqCLH8mYcdF5BQCj1R8D4y9URj03GfvFOP3tYwofiVKxwNmdSKTMpHxky1klcfE5uXglYLwgIm1tlZ1SblVOhDHNf3FI1JkZSfPtTHnjxbL8uDa~Gy4HfHZOvUE6buDVWALONzq1SYziK6E5SwKY132eNShWawxMCg2SwKParvwIP1v3NhFDAzG6Tfc8jcQV33B~t9klrofBM~dtnzVgjEW9CV197YNab60TMwBRk19Bnda-CLGhRnUJuMHLnhXMLSDD-ubR88DOmnLM2As5jK1IJ35d7LWFU-ECBcNli-JG31H5urriB0MVXT7b7qNE13kBxvBEeFooZOGCUg__',
                          height: 227.h,
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
    );
  }
}
