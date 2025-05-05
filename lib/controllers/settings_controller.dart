import 'package:get/get.dart';
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
}
