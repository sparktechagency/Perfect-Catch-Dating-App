import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../helpers/prefs_helpers.dart';
import '../../helpers/route.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../service/socket_services.dart';
import '../../utils/app_constants.dart';
import '../models/conversation_model.dart';

class MessageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isActive = false.obs;
  RxBool seenMessage = false.obs;
  RxList<MessageModel> messageModel = <MessageModel>[].obs;
  RxBool inboxFirstLoading = false.obs;
  RxBool sentMessageLoading = false.obs;
  var inboxPage = 1;
  var inboxTotalPages = 0;
  var inboxCurrentPage = 0;
  RxBool conversationLoading = false.obs;
  RxList<ConversationModel> conversationModel = <ConversationModel>[].obs;
  RxString imagesPath = ''.obs;
  File? selectedImage;
  final TextEditingController sentMsgCtrl = TextEditingController();
  final SocketServices _socket = SocketServices();

  @override
  void onInit() {
    super.onInit();
    _socket.init();
    conversation();
    message();
  }

  updateMessageScreen(param) async {
    var aa = await Get.toNamed(AppRoutes.messageScreen, parameters: param);
    update();
  }

  //===================================> GET CONVERSATIONS <===================================
  Future<void> conversation() async {
    _socket.socket!.on('conversation', (data) {
      List<ConversationModel> parseConversations(List<dynamic> json) {
        return json.map((data) => ConversationModel.fromJson(data)).toList();
      }
      conversationModel.clear();
      conversationModel.addAll(parseConversations(data));
    });
  }
  Future<void> getConversation() async {
    print(AppConstants.bearerToken);
    print('Requesting conversations from the socket...');
    await PrefsHelper.getString(AppConstants.userId).then((id) {
      print(" hello : ${id}");
      _socket.socket!.emit('conversation-page', {"currentUserId": id});
    });

  }

  //===================================> GET Messages <===================================
  Future<void> getMessage(String receiverID) async {
    print(receiverID);
    print('Requesting messages from the socket...');
    await _socket.init();
    _socket.socket!.emit('message-page', {"receiver": receiverID});
  }

  Future<void> message() async {
    print('Requesting messages from the socket...');
    _socket.socket!.on(
      'message',
          (data) {
        print('Update Message');
        print('=============================> $data');
        if (data != null && data.isNotEmpty) {
          messageModel.value = List<MessageModel>.from(data.map((x) => MessageModel.fromJson(x)));
          update();
        } else {
          print('No new messages or invalid data');
        }
      },
    );
  }

  /*inboxFirstLoad(String receiverId) async {
    inboxFirstLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllSingleMessageEndPoint(receiverId));
    if (response.statusCode == 200) {
      inboxFirstLoading(false);
      var data = response.body['data']['attributes']['data'];
      messageModel.value =
      List<MessageModel>.from(data.map((x) => MessageModel.fromJson(x)));
    } else {
      ApiChecker.checkApi(response);
    }
    inboxFirstLoading(false);
  }*/

  //===================================> LISTEN FOR NEW MESSAGES VIA SOCKET <===================================
  bool isListening = false;
  MessageModel newMessage = MessageModel.fromJson({});
  listenMessage(String receiverId) {
    if (_socket.socket == null) return;
    _socket.socket!.off('message');
    _socket.socket!.on("message", (data) {
      final messages = List<Map<String, dynamic>>.from(data);
      debugPrint("🔵 Live Message Received: $messages ");

      for (var item in data) {
        MessageModel receivedMessage = MessageModel.fromJson(item);

        if (!messageModel.any((msg) => msg.id == receivedMessage.id)) {
          messageModel.add(receivedMessage);
          messageModel.refresh();
          Future.delayed(const Duration(milliseconds: 100));
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          }
        }
      }
      update();
    });
  }


  //===================================> SEND A TEXT MESSAGE <===================================
  void sentMessage(String receiverId, String senderId, String text, String msgById) async {
    try {
      if (_socket.socket != null) {
        _socket.socket?.emit("new-message", {
          "sender": senderId,
          "receiver": receiverId,
          "text": text,
          "msgByUserId": msgById
        });

        print("message send");
        // final newMessage = MessageModel(
        //   text: text,
        //   msgByUserId: senderId,
        //   createdAt: DateTime.now(),
        //   type: 'text',
        //   id: UniqueKey().toString(),
        //   conversationId: '', imageUrl: '', videoUrl: '', fileUrl: '',
        //   seen: false,
        // );
        // messageModel.insert(0, newMessage);
        // messageModel.refresh();
        // update();
        // Future.delayed(const Duration(milliseconds: 100), () {
        //   if (scrollController.hasClients) {
        //     scrollController.animateTo(
        //       scrollController.position.minScrollExtent,
        //       duration: const Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //     );
        //   }
        // });
      } else {
        Fluttertoast.showToast(msg: "WebSocket not connected!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Socket Error: ${e.toString()}");
    } finally {
      sentMessageLoading(false);
    }
  }
}
