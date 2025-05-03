import 'package:get/get.dart';
import '../models/matches_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class MatchController extends GetxController {
  //=============================> Get Matches Data <===============================
  RxList<MatchesModel> matchesModel = <MatchesModel>[].obs;
  RxBool matchLoading = false.obs;
  getMatchData() async {
    matchLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllMatchesEndPoint);
    if (response.statusCode == 200) {
      matchLoading(false);
      var responseData = response.body['data']['attributes'];
      if (responseData is List) {
        matchesModel.assignAll(
          responseData.map((e) => MatchesModel.fromJson(e)).toList(),
        );
      } else {
        matchesModel.assignAll([MatchesModel.fromJson(responseData)]);
        matchLoading(false);
      }
    } else {
      ApiChecker.checkApi(response);
      matchLoading(false);
      update();
    }
  }
}
