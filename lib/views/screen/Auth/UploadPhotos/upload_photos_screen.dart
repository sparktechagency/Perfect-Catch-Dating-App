import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  List<String?> imagePaths = List.filled(6, null);
  final ImagePicker _picker = ImagePicker();

  //===================> Method to Pick an image <==========================
  Future<void> pickImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imagePaths[index] = pickedFile.path;
      });
    }
  }

  //====================> Method to remove an image <======================
  void removeImage(int index) {
    setState(() {
      imagePaths[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: AppStrings.showYourBestSelf.tr,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                bottom: 8.h,
              ),
            ),
            Center(
              child: CustomText(
                text: AppStrings.uploadYourSixBestPhotos.tr,
                fontSize: 16.sp,
                maxLine: 5,
                bottom: 8.h,
              ),
            ),
            SizedBox(height: 32.h),
            //=========================> Image Section <=======================
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                ),
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(index),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.cardColor,
                          ),
                          child:
                              imagePaths[index] != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.file(
                                      File(imagePaths[index]!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      AppIcons.add,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                        ),
                      ),
                      if (imagePaths[index] != null)
                        Positioned(
                          top: 0.h,
                          right: 0.w,
                          child: GestureDetector(
                            onTap: () => removeImage(index), // Remove image
                            child: SvgPicture.asset(
                              AppIcons.cancel,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            //=========================> Next Button <=======================
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.songListScreen);
              },
              text: AppStrings.continues.tr,
            ),
            SizedBox(height: 28.h),
          ],
        ),
      ),
    );
  }
}
