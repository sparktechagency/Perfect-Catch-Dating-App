import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/wallet_controller.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_app_bar.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../../models/wallet_model.dart';
import '../../base/custom_page_loading.dart';

class MyWalletScreen extends StatelessWidget {
   MyWalletScreen({super.key});
   final WalletController _controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    final WalletModel wallet;
    _controller.getWallet();
    _controller.getTransaction();
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.myWallet.tr),
      body: Obx(() {
        if (_controller.walletLoading.value) {
          return const Center(child: CustomPageLoading());
        }
        else if (_controller.walletModel.value == null) {
          return Center(child: CustomText(text: "Notification is empty".tr));
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //====================> Balance Container Row <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _balanceContainer('\$${_controller.walletModel.value.userWallet!.balance}', AppStrings.totalBalance.tr),
                  _balanceContainer('\$${_controller.walletModel.value.totalWithdraw}', AppStrings.totalWithdrawal.tr),
                ],
              ),
              SizedBox(height: 48.h),
              //====================> Payment Button <==================
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.paymentScreen);
                },
                text: AppStrings.payment.tr,
              ),
              SizedBox(height: 16.h),
              //====================> Withdraw balance Button <==================
              CustomButton(
                onTap: () {},
                text: AppStrings.withdrawBalance.tr,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 16.h),
              //====================> Recharge balance Button <==================
              CustomButton(
                onTap: () {},
                text: AppStrings.rechargeBalance.tr,
                color: Colors.white,
                textColor: Colors.black,
              ),
              SizedBox(height: 32.h),
              //====================> Transactions History <==================
              CustomText(
                text: AppStrings.transactionsHistory.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                maxLine: 3,
                bottom: 16.h,
              ),
              Expanded(
                child: _controller.transaction.isEmpty
                    ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(width: 1.0, color: AppColors.primaryColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: CustomText(
                        text: 'No transactions available'.tr,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.transaction.length,
                  itemBuilder: (context, index) {
                    final transaction = _controller.transaction[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(width: 1.0, color: AppColors.primaryColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //====================> Transaction Status <==================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: AppStrings.withdrawal.tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: transaction.status == "completed" ? 'Completed'.tr : 'Pending'.tr,
                                  color: transaction.status == "completed" ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            //====================> Total amount <==================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Total Amount :'.tr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: '\$${transaction.amount}'.tr,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.0),
                            Divider(thickness: 0.6, color: Colors.grey.shade200),
                            SizedBox(height: 2.0),
                            //====================> Payment Date <==================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Payment Date :'.tr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  maxLine: 3,
                                ),
                                CustomText(
                                  text: transaction.timestamp != null ? '${transaction.timestamp!.toLocal()}'.tr : 'Unknown Date'.tr,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }

  //========================> BalanceContainer Method <=============================
   _balanceContainer(String balance, title) {
     return Stack(
       clipBehavior: Clip.none,
       children: [
         Container(
           width: 173.w,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(18.r),
             border: Border.all(width: 1.w, color: AppColors.primaryColor),
           ),
           child: Padding(
             padding: EdgeInsets.all(24.w),
             child: Column(
               children: [
                 SvgPicture.asset(AppIcons.doller),
                 SizedBox(height: 16.h),
                 CustomText(
                   text: balance,
                   fontWeight: FontWeight.w600,
                   fontSize: 24.sp,
                   maxLine: 3,
                 ),
               ],
             ),
           ),
         ),
         Positioned(
           right: 6.w,
           left: 6.w,
           bottom: -15.h,
           child: Container(
             decoration: BoxDecoration(
               color: AppColors.primaryColor,
               border: Border.all(width: 1.w, color: AppColors.primaryColor),
               borderRadius: BorderRadius.circular(21.r),
             ),
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
               child: CustomText(
                 text: title,
                 fontWeight: FontWeight.w600,
                 fontSize: 16.sp,
                 color: Colors.white,
               ),
             ),
           ),
         ),
       ],
     );
   }

}
