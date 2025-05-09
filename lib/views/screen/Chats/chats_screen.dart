import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/time_formate.dart';

import 'package:perfect_catch_dating_app/utils/app_strings.dart';

import 'package:perfect_catch_dating_app/views/base/custom_network_image.dart';

import 'package:perfect_catch_dating_app/views/base/custom_text.dart';

import 'package:perfect_catch_dating_app/views/base/custom_text_field.dart';

import '../../../controllers/match_controller.dart';

import '../../../controllers/message_controller.dart';

import '../../../models/matches_model.dart';

import '../../../service/api_constants.dart';

import '../../../service/socket_services.dart';

import '../../base/bottom_menu..dart';

import '../../base/custom_page_loading.dart';

class ChatsScreen extends StatefulWidget {

  ChatsScreen({super.key});

  @override

  State<ChatsScreen> createState() => _ChatsScreenState();

}

class _ChatsScreenState extends State<ChatsScreen> {

  final TextEditingController _searchCTRL = TextEditingController();

  final MessageController controller = Get.put(MessageController());

  final SocketServices _socket = SocketServices();

  final MatchController _matchController = Get.put(MatchController());

  var currentUserId = '';

  @override

  void initState() {

    super.initState();
    _socket.init();


    _matchController.getMatchData();

    _socket.init();

    controller.getConversation();

    controller.conversation();

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomMenu(3),

      appBar: AppBar(title: Text('Chats'.tr)),

      body: Padding(

        padding: EdgeInsets.symmetric(horizontal: 20.w),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //==========================> Search Bar <==========================

            CustomTextField(

              controller: _searchCTRL,

              hintText: AppStrings.search.tr,

              prefixIcon: Padding(

                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Icon(Icons.search, color: Colors.grey),

              ),

            ),

            SizedBox(height: 16.h),

            //==========================> Your Match Section <==========================

            CustomText(

              text: AppStrings.yourMatch.tr,

              fontSize: 16.sp,

              fontWeight: FontWeight.bold,

            ),

            SizedBox(height: 10.h),

            Obx(() {

              if (_matchController.matchLoading.value) {

                return const Center(child: CustomPageLoading());

              } else if (_matchController.matchesModel.isEmpty) {

                return Center(child: CustomText(text: 'No matches found'.tr));

              }

              return Expanded(

                //flex: 1,

                child: ListView.builder(

                  shrinkWrap: true,

                  addAutomaticKeepAlives: true,

                  scrollDirection: Axis.horizontal,

                  itemCount: _matchController.matchesModel.length,

                  itemBuilder: (context, index) {

                    final MatchesModel user =

                    _matchController.matchesModel[index];

                    return Padding(

                      padding: EdgeInsets.only(right: 10.w),

                      child: Column(

                        children: [

                          CustomNetworkImage(

                            imageUrl:

                            '${ApiConstants.imageBaseUrl}${user.profileImage}',

                            height: 56.h,

                            width: 56.w,

                            boxShape: BoxShape.circle,

                          ),

                          CustomText(text: '${user.fullName}'),

                        ],

                      ),

                    );

                  },

                ),

              );

            }),

            SizedBox(height: 16.h),

            //==========================> Chats (recent) Section <==========================

            CustomText(

              text: AppStrings.chatsRecent.tr,

              fontSize: 16.sp,

              fontWeight: FontWeight.bold,

            ),

            //=============================> Chats List <====================================

            Obx(() {

              print("obx read : ${controller.conversationModel}");
              if (controller.conversationModel.isEmpty) {

                return Expanded(child: Center(child: CustomText(text: 'No conversations found'.tr)));

              }

              return Expanded(
                child: ListView.builder(

                  shrinkWrap: true,

                  addAutomaticKeepAlives: false,

                  itemCount: controller.conversationModel.length,

                  itemBuilder: (context, index) {

                    final conversation = controller.conversationModel[index];

                    String? conversationId = conversation.id;

                    String? displayName = conversation.receiver.fullName;

                    String? displayImage = conversation.receiver.profileImage;

                    String? receiverId = conversation.receiver.id;

                    return Padding(

                      padding: EdgeInsets.only(bottom: 8.h),

                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => controller.updateMessageScreen({

                          "conversationId": conversationId,

                          "currentUserId": conversation.sender.id,

                          "receiverId": receiverId,

                          "receiverImage": displayImage,

                          "receiverName": displayName,

                        }),

                        child: Padding(

                          padding: EdgeInsets.symmetric(

                            horizontal: 12.w,

                            vertical: 16.h,

                          ),

                          child: Row(

                            children: [

                              CustomNetworkImage(

                                imageUrl:

                                '${ApiConstants.imageBaseUrl}$displayImage',

                                height: 56.h,

                                width: 56.w,

                                boxShape: BoxShape.circle,

                              ),

                              SizedBox(width: 12.w),

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    //=====================> Name <=======================

                                    CustomText(

                                      text: controller.conversationModel[index].receiver.fullName,

                                      fontSize: 12.sp,

                                      fontWeight: FontWeight.w700,

                                      bottom: 6.h,

                                      maxLine: 2,

                                      textAlign: TextAlign.start,

                                    ),

                                    //=====================> Last Message <=======================

                                    CustomText(

                                      text: controller.conversationModel[index].lastMsg != null ? controller.conversationModel[index].lastMsg!.text : '',

                                      fontWeight: FontWeight.w500,

                                      textAlign: TextAlign.start,

                                    ),

                                  ],

                                ),

                              ),

                              Spacer(),

                              //==========================> Time and Unread Count Column <========================

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [

                                  CustomText(

                                    text: controller.conversationModel[index].lastMsg != null ? TimeFormatHelper.timeAgo(controller.conversationModel[index].lastMsg!.createdAt) : '',

                                    fontSize: 10.sp,

                                    color: Colors.grey,

                                  ),

                                  SizedBox(height: 8.h),

                                  Container(

                                    padding: EdgeInsets.all(6.w),

                                    decoration: BoxDecoration(

                                      color: Colors.blue,

                                      shape: BoxShape.circle,

                                    ),

                                    child: CustomText(

                                      text: controller.conversationModel[index].lastMsg != null ? controller.conversationModel[index].unseenMsg.toString() : '',
                                      fontSize: 12.sp,

                                      color: Colors.white,

                                      fontWeight: FontWeight.bold,

                                    ),

                                  ),

                                ],

                              ),

                            ],

                          ),

                        ),

                      ),

                    );

                  },

                ),

              );

            }),

          ],

        ),

      ),

    );

  }

}

