import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
import 'package:perfect_catch_dating_app/service/api_client.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_constants.dart';

class CallController extends GetxController{
  RxBool isAgoraInitialized = false.obs;
  RxBool isCallingLoading = false.obs;
  RxString agoraToken = ''.obs;
  RxString agoraTChannelName = ''.obs;

  Future<bool> getCallToken({required String type, required String receiverName}) async{
    isCallingLoading.value = true;
    Future.delayed(Duration(seconds: 3));
    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await ApiClient.getData(
        ApiConstants.getCallTokenEndPoint(type, receiverName),
        headers: headers
    );


    if(response.statusCode == 200 || response.statusCode == 201){
      isCallingLoading.value = false;
      agoraToken.value = response.body['data']['attributes']['token'];
      agoraTChannelName.value = response.body['data']['attributes']['channelName'];
      print("token : ${agoraToken.value}");
      print("token channel name: ${agoraTChannelName.value}");
      return true;
    }
    isCallingLoading.value = false;
    return false;
  }

}