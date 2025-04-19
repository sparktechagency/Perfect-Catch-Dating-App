import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/custom_app_bar.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final List<Map<String, String>> songs = [
    {'title': 'Electric Feel', 'artist': 'MGMT', 'image': AppImages.music},
    {'title': 'Sweetener', 'artist': 'Ariana Grande', 'image': AppImages.music},
    {'title': 'Lemonade', 'artist': 'Calum Scott', 'image': AppImages.music},
    {'title': 'Sunset', 'artist': 'Maggie Rogers', 'image': AppImages.music},
    {
      'title': 'Ocean Eyes',
      'artist': 'Billie Eilish',
      'image': AppImages.music,
    },
    {'title': 'Shape Of You', 'artist': 'Ed Sheeran', 'image': AppImages.music},
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'image': AppImages.music,
    },
  ];

  String? selectedSong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.songList.tr),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //====================> Search Bar <===================
            TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchForSongs.tr,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              ),
            ),
            SizedBox(height: 16.h),
            //====================> Song Tab <===================
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.subscriptionScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.primaryColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: CustomText(text: AppStrings.mostPopularSong.tr),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //====================> Song List <===================
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: songs.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(song['image']!),
                    ),
                    title: CustomText(text: song['title']!),
                    subtitle: CustomText(text: song['artist']!),
                    trailing: IconButton(
                      icon: Icon(
                        selectedSong == song['title']
                            ? Icons.check_circle
                            : Icons.download,
                        color:
                            selectedSong == song['title']
                                ? AppColors.primaryColor
                                : Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSong =
                              selectedSong == song['title']
                                  ? null
                                  : song['title'];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
