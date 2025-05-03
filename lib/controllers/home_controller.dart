import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
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


    for(final val in usersList){
      print("user iterate: ${val.fullName}");
    }
  }

}


