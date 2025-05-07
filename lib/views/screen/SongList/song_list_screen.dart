import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/song_controller.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_button.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_page_loading.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../../models/song_model.dart';
import '../../base/custom_app_bar.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final SongController _songController = Get.put(SongController());

  String searchQuery = "";
  List<SongModel> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _songController.getSongList();
    filteredSongs = _songController.songList;
  }

  //==================> Method to filter songs by name <========================
  void filterSongs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredSongs = _songController.songList;
      } else {
        filteredSongs =
            _songController.songList.where((song) {
              return song.name?.toLowerCase().contains(query.toLowerCase()) ??
                  false;
            }).toList();
      }
    });
  }

  @override
  void dispose() {
    _songController.playSong(_songController.selectedSong ?? "");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.songList.tr),
      body: GetBuilder<SongController>(
        init: SongController(),
        builder:
            (controller) => Obx(
              () =>
                  _songController.songLoading.value
                      ? CustomPageLoading()
                      : Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //====================> Search Bar <===================
                            TextField(
                              onChanged: filterSongs,
                              decoration: InputDecoration(
                                hintText: AppStrings.searchForSongs.tr,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            //====================> Song Update Button <===================
                            Obx(()=> CustomButton(
                                loading: _songController.songUpDateLoading.value,
                                width: 134.w,
                                  height: 46.h,
                                  onTap: _songController.updateBackgroundMusic,
                                  text: 'Update'.tr,
                              color: _songController.selectedSong != null ? AppColors.primaryColor : Colors.grey,
                            ),
                            ),
                            SizedBox(height: 16.h),
                            //====================> Song List <===================
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: filteredSongs.length,
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  final song = filteredSongs[index];
                                  return InkWell(
                                    onTap: () {
                                      _songController.playSong(song.music!);
                                    },
                                    child: Row(
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl:
                                              '${ApiConstants.imageBaseUrl}${song.image}',
                                          height: 60.h,
                                          width: 60.w,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        SizedBox(width: 14.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: '${song.name}',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                maxLine: 2,
                                                textAlign: TextAlign.start,
                                                bottom: 4.h,
                                              ),
                                              CustomText(
                                                text: '${song.subTitle}',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(
                                            _songController.selectedSong ==
                                                    song.music
                                                ? Icons.check_circle
                                                : Icons.download,
                                            color:
                                                _songController.selectedSong ==
                                                        song.music
                                                    ? AppColors.primaryColor
                                                    : Colors.blue,
                                          ),
                                          onPressed: () {
                                            _songController.playSong(
                                              song.music!,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
      ),
    );
  }
}
