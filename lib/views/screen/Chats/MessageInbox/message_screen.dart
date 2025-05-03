import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import '../../../../controllers/message_controller.dart';
import '../../../../helpers/prefs_helpers.dart' show PrefsHelper;
import '../../../../helpers/time_formate.dart';
import '../../../../models/message_model.dart';
import '../../../../service/api_constants.dart';
import '../../../../service/socket_services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_loading.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final MessageController _controller = Get.put(MessageController());
  final SocketServices _socket = SocketServices();
  TextEditingController messageController = TextEditingController();

  final params = Get.parameters;
  var conversationId = "";
  var currentUserId = "";
  var currentUserName = "";
  var receiverImage = "";
  var receiverName = "";
  var receiverId = "";

  @override
  void initState() {
    super.initState();
    _socket.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserId();
      conversationId = Get.parameters['conversationId']!;
      currentUserId = params['currentUserId'] ?? "";
      receiverImage = params['receiverImage'] ?? "";
      receiverName = params['receiverName'] ?? "";
      receiverId = params['receiverId'] ?? "";
      _socket.emitMessagePage(receiverId);
      //_controller.inboxFirstLoad(receiverId);
      _controller.listenMessage(receiverId);
      _controller.getMessage(receiverId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUserId() async {
    currentUserId = await PrefsHelper.getString(AppConstants.userId);
    currentUserName = await PrefsHelper.getString(AppConstants.userName);
  }

  Future<void> _refreshMessages() async {
    getUserId();
    // _controller.inboxFirstLoad(conversationId);
    _controller.listenMessage(conversationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      //========================================> AppBar Section <=======================================
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        titleSpacing: 0.w,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:
                  "${ApiConstants.imageBaseUrl}${Get.parameters["receiverImage"]}",
              height: 45.h,
              width: 45.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: CustomText(
                text: "${Get.parameters["receiverName"]}",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          //==============================> Audio Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.audio)),
          SizedBox(width: 18.w),
          //==============================> Video Call Button <=======================
          InkWell(onTap: () {}, child: SvgPicture.asset(AppIcons.video)),
          _popupMenuButton(),
          SizedBox(width: 4.w),
        ],
      ),
      //========================================> Body Section <=======================================
      body: GetBuilder<MessageController>(
        builder:
            (controller) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: _refreshMessages,
                            child: ListView.builder(
                              itemCount: controller.messageModel.length,
                              controller: _controller.scrollController,
                              reverse: true,
                              itemBuilder: (context, index) {
                                final message = controller.messageModel[index];
                                return message.msgByUserId == currentUserId
                                    ? senderBubble(context, message)
                                    : receiverBubble(context, message);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Write your message...",
                  suffixIcons: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        if (_controller.sentMsgCtrl.text.isNotEmpty &&
                            !_controller.sentMessageLoading.value) {
                          _controller.sentMessage(
                            receiverId,
                            PrefsHelper.userId,
                            _controller.sentMsgCtrl.text,
                            PrefsHelper.userId,
                          );
                          _controller.sentMsgCtrl.clear();
                        } else {
                          Fluttertoast.showToast(msg: 'Please write a message');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(
                            AppIcons.sendIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppIcons.gift),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //=============================================> Receiver Bubble <=================================
  receiverBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          imageUrl: '${ApiConstants.imageBaseUrl}$receiverImage',
          boxShape: BoxShape.circle,
          height: 38.h,
          width: 38.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: AppColors.cardColor,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                        borderRadius: BorderRadius.circular(8.r),
                        height: 140.h,
                        width: 155.w,
                      )
                      : Text(
                        '${message.text}',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        textAlign: TextAlign.start,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //=============================================> Sender Bubble <========================================
  senderBubble(BuildContext context, MessageModel message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.type == 'image' && message.imageUrl != null
                      ? CustomNetworkImage(
                        imageUrl:
                            '${ApiConstants.imageBaseUrl}${message.imageUrl}',
                        borderRadius: BorderRadius.circular(8.r),
                        height: 140.h,
                        width: 155.w,
                      )
                      : Text(
                        "${message.text}",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.start,
                      ),
                  Text(
                    '${TimeFormatHelper.timeAgo(message.createdAt!)}',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //==================================> Gallery <===============================
  /*  Future openGallery() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      selectedIMage = File(pickImage!.path);
      _image = File(pickImage.path).readAsBytesSync();
    });
  }*/

  //================================> Popup Menu Button Method <=============================
  PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      icon: SvgPicture.asset(AppIcons.dot, color: Colors.white),
      onSelected: (int result) {
        if (result == 0) {
          print('View Profile');
        } else if (result == 1) {
          print('Delete Chat ');
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              value: 0,
              child: const Text(
                'View Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem<int>(
              onTap: () {
                _showCustomBottomSheet(context);
              },
              value: 1,
              child: const Text(
                'Delete Chat',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  }

  //===============================> Delete conversation Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(width: 2.w, color: AppColors.primaryColor),
            ),
            color: AppColors.cardColor,
          ),
          height: 265.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5),
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: AppStrings.deleteConversation.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(
                width: 190.w,
                child: Divider(color: AppColors.primaryColor),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: 'Are you sure you want to delete this conversation?'.tr,
                maxLine: 5,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      Get.back();
                    },
                    text: "No",
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      // Get.offAllNamed(AppRoutes.signInScreen);
                    },
                    text: "Yes",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
