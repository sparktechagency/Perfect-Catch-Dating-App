import 'dart:math';

import 'package:get/get.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SettingController extends GetxController {
  //==============================> Get Terms and Condition Method <==========================
  RxBool termsConditionLoading = false.obs;
  RxString termContent = ''.obs;
  getTermsCondition() async {
    termsConditionLoading(true);
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(
      ApiConstants.termsConditionEndPoint,
      headers: header,
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'];
      if (attributes != null && attributes.isNotEmpty) {
        var content = attributes[0]['content'];
        termContent.value = content;
      } else {
        termContent.value = 'No content available';
      }
      termsConditionLoading(false);
    } else {
      ApiChecker.checkApi(response);
      termsConditionLoading(false);
      update();
    }
  }

  //==========================> Get Privacy Policy Method <=======================
  RxBool privacyLoading = false.obs;
  RxString privacyContent = ''.obs;
  getPrivacy() async {
    privacyLoading(true);
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(
      ApiConstants.privacyPolicyEndPoint,
      headers: header,
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'];
      if (attributes != null && attributes.isNotEmpty) {
        var content = attributes[0]['content'];
        privacyContent.value = content;
      } else {
        privacyContent.value = 'No content available';
      }
      privacyLoading(false);
    } else {
      ApiChecker.checkApi(response);
      privacyLoading(false);
      update();
    }
  }

  //==============================> Get About Us Method <==========================
  RxBool aboutUsLoading = false.obs;
  RxString aboutContent = ''.obs;
  getAboutUs() async {
    aboutUsLoading(true);
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.getData(
      ApiConstants.aboutUsEndPoint,
      headers: header,
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes'];
      if (attributes != null && attributes.isNotEmpty) {
        var content = attributes[0]['content'];
        aboutContent.value = content;
      } else {
        aboutContent.value = 'No content available';
      }
      aboutUsLoading(false);
    } else {
      ApiChecker.checkApi(response);
      aboutUsLoading(false);
      update();
    }
  }

  //==========================> Revenue Cat Subscription <===================
  var oferLoading=false.obs;
  var subscription=false.obs;
  RxList<Package> packages=<Package>[].obs;
  String? currentProductId;
  getOffiering()async{
    subscription.value=true;
    Offerings offerings = await Purchases.getOfferings();
    Offering? current = offerings.current;
    if (current != null && current.availablePackages.isNotEmpty) {
      packages.value = current.availablePackages;
      subscription(false);
      update();
      print('Package>>>>>>>>>>>>>>>>$packages');
// print('Package>>>>>>>>>>>>>>>>$offerings');
// Show these packages in your custom UI
    }
  }

  payment(Package package)async{
    oferLoading(true);
//final product = package.storeProduct;
    try {
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      if (customerInfo.entitlements.all["premium"]?.isActive == true) {
        final customerId = customerInfo.originalAppUserId;
        final amount = package.storeProduct.priceString;
        final currencyCode = package.storeProduct.currencyCode;
        //paymentHandel(customerId,amount,currencyCode);
        oferLoading(false);
        update();
// Optional: set state or refresh offerings
      } else {
        oferLoading(false);
        update();
      }
    } catch (e) {
    }
  }
}
