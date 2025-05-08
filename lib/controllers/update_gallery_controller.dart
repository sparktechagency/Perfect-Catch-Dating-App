import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';
import '../utils/logger.dart';

class UpdateGalleryController extends GetxController {
  var imagePaths = List<String>.filled(6, '').obs;
  var uploadGalleryLoading = false.obs;

  uploadGalleryImages({bool isUpdate = false}) async {
    if (imagePaths.isEmpty) {
      print("No images selected for upload.");
      return;
    }

    var isFirstTimeUpdateGallery = await PrefsHelper.getBool(AppConstants.hasUpdateGallery);
    showInfo(isFirstTimeUpdateGallery.toString());

    uploadGalleryLoading(true);
    List<MultipartBody> multipartBody =
        imagePaths.map((path) => MultipartBody('photos', File(path))).toList();
    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateGalleryEndPoint,
      {},
      multipartBody: multipartBody,
    );
    uploadGalleryLoading(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      imagePaths.assignAll(List.filled(6, ''));
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!isUpdate) {
          markProfileAsComplete();
          Get.offAllNamed(AppRoutes.locationScreen);
        } else {
          Get.back();
        }
      });
    } else {
      ApiChecker.checkApi(response);
    }
  }

  markProfileAsComplete() async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    await ApiClient.patchData(
        ApiConstants.updatePersonalInfoEndPoint,
        jsonEncode({"isProfileCompleted": true,}),
        headers: headers
    );
  }
}
