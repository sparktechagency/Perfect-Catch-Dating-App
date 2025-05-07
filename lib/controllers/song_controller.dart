import 'dart:convert';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SongController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  String? selectedSong;

  RxList<SongModel> songList = <SongModel>[].obs;
  RxBool songLoading = false.obs;
  RxBool songUpDateLoading = false.obs;

  //========================> Fetch Song List <======================
  getSongList() async {
    songLoading(true);
    var response = await ApiClient.getData(ApiConstants.getMusicEndPoint);
    if (response.statusCode == 200) {
      var songs = List<SongModel>.from(
        response.body['data']['attributes']['results'].map(
          (song) => SongModel.fromJson(song),
        ),
      );
      songList.value = songs;
      songLoading(false);
    } else {
      ApiChecker.checkApi(response);
      songLoading(false);
    }
  }

  //========================> Play Song <===========================
  playSong(String url) async {
    final fullUrl = "${ApiConstants.imageBaseUrl}$url";

    print(fullUrl);
    print("selectedSong $selectedSong");

    try {
      // If the same song is already playing, stop it
      if (audioPlayer.playing && url == selectedSong) {
        selectedSong = null;
        update();
        await audioPlayer.stop();
        isPlaying(false);
        return;
      }
      selectedSong = url;
      update();
      await audioPlayer.stop();
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(fullUrl)));
      await audioPlayer.play();
      isPlaying(true);
    } catch (e) {
      print("Error playing song: $e");
      isPlaying(false);
    }
  }

  //====================> Update Background Music <======================
  updateBackgroundMusic() async {
    songUpDateLoading(true);
    if (selectedSong == null) {
      Get.snackbar('Error', 'No song selected');
      return;
    }

    Map<String, String> body = {'backgroundMusic': selectedSong!};
    var response = await ApiClient.patchData(
      ApiConstants.updatePersonalInfoEndPoint,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      songUpDateLoading(false);
      print('Background music updated successfully');
      Get.back();
    } else {
      ApiChecker.checkApi(response);
      songUpDateLoading(false);
      update();
    }
  }
}
