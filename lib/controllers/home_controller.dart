import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/models/user_model.dart';
import 'package:perfect_catch_dating_app/service/api_client.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_constants.dart';

class HomeController extends GetxController{

  var usersList = <UserModel>[].obs;
  RxBool isProfilesLoading = false.obs;

  Future<void> getAllUsersProfiles() async{
    isProfilesLoading.value = true;
    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await ApiClient.getData(
        ApiConstants.getAllUsersProfilesEndPoint,
        headers: headers
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      isProfilesLoading.value = false;
      usersList.value = (response.body['data']['attributes'] as List).map((user) => UserModel.fromJson(user)).toList();
    }
    isProfilesLoading.value = false;
  }


  Future<void> userReaction({required String profileId, required String reaction, required String matchesUserProfile, required String matchesProfileId}) async{
    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var body = {
      'profileId': profileId,
      'reaction': reaction,
    };

    Response response = await ApiClient.postData(
        ApiConstants.usersReactionEndPoint,
        jsonEncode(body),
        headers: headers
    );


    if(response.statusCode == 200 || response.statusCode == 201){
      Fluttertoast.showToast(msg: response.body["message"]);
      if(response.body['data']['attributes']['match']){
        Get.toNamed(AppRoutes.homeMatchScreen, arguments: {
          "matchesProfileId": matchesProfileId,
          "matchesUserProfile": matchesUserProfile,
        });
      }
    }
  }

//==============================> Get User Details <=============================
  final Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isProfilesDetailsLoading = false.obs;

  Future<void> getUsersProfilesDetails({required String userId}) async{
    isProfilesDetailsLoading.value = true;
    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await ApiClient.getData(
        ApiConstants.getSingleHomeUserEndPoint(userId),
        headers: headers
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      isProfilesDetailsLoading.value = false;
      user.value = UserModel.fromJson(response.body['data']['attributes']);
    }
    isProfilesDetailsLoading.value = false;
  }

}


