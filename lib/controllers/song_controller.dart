import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/song_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SongController extends GetxController{
  String? selectedSong;

  //=============================> Get Song List <===============================
  Rx<SongModel> songModel = SongModel().obs;
  RxBool songLoading = false.obs;
  getSongList() async {
    songLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getPersonalInfoEndPoint,
    );

    if (kDebugMode) {
      print("my response ==============>: ${response.body}");
    }

    if (response.statusCode == 200) {
      songModel.value = SongModel.fromJson(
        response.body['data']['attributes']['results'],
      );
      songLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      songLoading(false);
      update();
    }
  }


}