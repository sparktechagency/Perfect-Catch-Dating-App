import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/service/socket_services.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_icons.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';

import '../../base/custom_text_field.dart';

class HomeMatchScreen extends StatefulWidget {
  const HomeMatchScreen({super.key});

  @override
  State<HomeMatchScreen> createState() => _HomeMatchScreenState();
}

class _HomeMatchScreenState extends State<HomeMatchScreen> {
  final SocketServices _socket = SocketServices();
  String userId = '';
  String userImage = '';

  @override
  void initState() {
    super.initState();
    PrefsHelper.getString(AppConstants.userId).then((id) {
      userId = id;
      _initializeSocket(userId);
    });
    PrefsHelper.getString(AppConstants.userId).then((image) {
      userImage = image;
    });
  }

  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }

  void _initializeSocket(String receiver) async {
    await _socket.init();

    _socket.socket!.on('message', (data) {
      if(mounted){
        if(data is List){
          if(data.isNotEmpty){
            Fluttertoast.showToast(msg: "Your message sent successfully");
            Get.back();
          }
          else{
            Fluttertoast.showToast(msg: "Something went wrong!!");
          }
        }
        else{
          Fluttertoast.showToast(msg: "Something went wrong!!");
        }
        print("data print : ${data}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final data = Get.arguments;
    // data["matchesProfileId"]
    final TextEditingController msgController = TextEditingController();


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.s,
              children: [
                SizedBox(width: 80),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Bottom card (first card) - No rotation applied
                    // Transform.translate(
                    //   offset: Offset(0, 0),
                    //   child: Container(
                    //     width: 150,
                    //     height: 200,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: NetworkImage(
                    //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5j35_oC1j1LFQJDFrG8yTXRw7uovR3b1u4w&s',
                    //         ),
                    //         fit: BoxFit.cover,
                    //       ),
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),
                    Transform.translate(
                      offset: Offset(120, -40),
                      child: Transform.rotate(
                        angle: 0.35, // Tilt in the opposite direction
                        child: Container(
                          width: 150,
                          height: 220,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "${ApiConstants.imageBaseUrl}$userImage",
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .moveX(begin: -150, end: 0, delay: 1000.ms),
                    Transform.translate(
                      offset: Offset(-20, -20),
                      child: Transform.rotate(
                        angle: -0.35, // Rotate by a small angle (in radians)
                        child: Container(
                          width: 150,
                          height: 220,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                data != null ? "${ApiConstants.imageBaseUrl}${data["matchesUserProfile"]}" : "",
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ).animate().moveX(begin: 150, end: 0, delay: 1000.ms),
                    Transform.translate(
                      offset: Offset(70, 40),
                      child: Image.asset(AppImages.centerCardImage)
                          .animate(delay: 1000.ms)
                          .fadeIn(delay: 1200.ms)
                          .shimmer(delay: 800.ms, duration: 1200.ms)
                          .shakeX(curve: Curves.linear),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // "What A Match!" text
            Text(
              "What A Match!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Now you have 24 hours to start chatting ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            Container(
              height: Get.height * .25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.primaryColor.withValues(alpha: 0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Ciaras payer’s opening move",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: Get.height * .15,
                        width: Get.width * .8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: Text(
                                "Guess my pet’s name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.1,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: msgController,
                  hintText: "Write your message...",
                ),
              ),

              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                 if(data != null){
                   _socket.emit("new-message", {
                     "sender": userId,
                     "receiver": data["matchesProfileId"],
                     "text": msgController.text,
                     "msgByUserId": userId,
                   });
                   msgController.clear();
                 }
                },
                child: SvgPicture.asset(AppIcons.sendIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
