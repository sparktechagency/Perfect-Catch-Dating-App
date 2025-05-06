import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/custom_app_bar.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final List<Map<String, String>> songs = [
    {
      'title': 'Electric Feel',
      'artist': 'MGMT',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Sweetener',
      'artist': 'Ariana Grande',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Lemonade',
      'artist': 'Calum Scott',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Sunset',
      'artist': 'Maggie Rogers',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Ocean Eyes',
      'artist': 'Billie Eilish',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Shape Of You',
      'artist': 'Ed Sheeran',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
    },
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'image':
          'https://t4.ftcdn.net/jpg/04/10/17/95/360_F_410179527_ExxSzamajaCtS16dyIjzBRNruqlU5KMA.jpg',
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(width: 1.w, color: AppColors.primaryColor),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: CustomText(text: AppStrings.mostPopularSong.tr),
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
                  return Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: song['image']!,
                        height: 60.h,
                        width: 60.w,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: song['title']!,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              maxLine: 2,
                              textAlign: TextAlign.start,
                              bottom: 4.h,
                            ),
                            CustomText(text: song['artist']!),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
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
                    ],
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
