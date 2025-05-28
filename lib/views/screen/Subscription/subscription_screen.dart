import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/settings_controller.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/style.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final SettingController _controller = Get.put(SettingController());

  bool isChecked = false;
  bool isSelected = false;
  String selectedOption = 'Basic';

  @override
  void initState() {
    _controller.getOffiering();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Subscription'.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: _controller.packages.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            final package = _controller.packages[index];
            final product = package.storeProduct;

            bool isCurrent = product.identifier == _controller.currentProductId;
            print('CurrentId ${product.identifier}');
            print('CurrentId ${_controller.currentProductId}');
            print('CurrentId Check  ${isCurrent}');


            return InkWell(
              onTap: ()
              async {
                _controller.payment(package);
              },
              borderRadius: BorderRadius.circular(13),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top row with icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.black,
                            child: Center(
                              child: SvgPicture.asset(AppIcons.sub),
                            ),
                          ),
                          // You can mark current plan with extra logic if needed
                          isCurrent==true? Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black
                            ),
                            child: Text('Current Plan',style: AppStyles.h4(color: AppColors.primaryColor),),
                          ):SizedBox()
                        ],
                      ),
                      SizedBox(height: 10.h),

                      /// Title
                      Text(product.title, style: AppStyles.h2()),
                      Text(product.description, style: AppStyles.h6()),

                      Divider(color: AppColors.dividerColor),

                      /// Price
                      Row(
                        children: [
                          Text(product.priceString, style: AppStyles.h3()),
                          SizedBox(width: 4),
                          // Text("/${product.subscriptionPeriod?.name.toLowerCase() ?? "month"}",
                          //     style: AppStyles.h6()),
                        ],
                      ),
                      SizedBox(height: 34.h),
                      //======================> Pay Now Button <=========================
                      CustomButton(
                        color: AppColors.whiteColor,
                        textColor: AppColors.blackColor,
                        onTap: () {
                          _controller.payment(package);
                        },
                        text: 'Pay Now'.tr,
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            );
          },
        )
        /*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            //======================> Subscription Container Row <=========================
            Row(
              children: [
                Expanded(
                  child: _subscriptionContainer(
                    AppStrings.basic.tr,
                    '1 Month'.tr,
                    'Free',
                    '/Monthly',
                    'Basic',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _subscriptionContainer(
                    AppStrings.premium.tr,
                    '3 Month'.tr,
                    '\$20.99',
                    '/Yearly',
                    'Premium',
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(height: 34.h),
            //======================> Pay Now Button <=========================
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.paymentScreen);
              },
              text: 'Pay Now'.tr,
            ),
            SizedBox(height: 32.h),
          ],
        ),*/
      ),
    );
  }
  //=============================> Subscription Container Widget <=============================
  _subscriptionContainer(
    String type,
    String title,
    String price,
    String duration,
    String option,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.w,
                color:
                    selectedOption == option
                        ? AppColors.primaryColor
                        : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(32.r),
              color: AppColors.whiteColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //========================> Subscription Title <=========================
                  Center(
                    child: CustomText(
                      text: title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      maxLine: 2,
                      textAlign: TextAlign.center,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(color: AppColors.primaryColor, thickness: 2.0),
                  SizedBox(height: 16.h),
                  //==========================> Subscription Features <=========================
                  _featureRow('Limited profile views per day'),
                  SizedBox(height: 16.h),
                  _featureRow('Limited voice notes and message'),
                  SizedBox(height: 16.h),
                  _featureRow('Standard verification process'),
                  SizedBox(height: 32.h),
                  //==========================> Subscription Amount and Time <=========================
                  Row(
                    children: [
                      CustomText(
                        text: price,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: duration,
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -10.h,
            right: 50.w,
            left: 50.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: CustomText(
                  text: type,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //==============================> Subscription Feature Row <==================
  _featureRow(String title) {
    return Row(
      children: [
        Container(
          width: 14.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.done, color: Colors.white, size: 10),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: CustomText(
            text: title.tr,
            fontSize: 8.sp,
            maxLine: 3,
            textAlign: TextAlign.start,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
