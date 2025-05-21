import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../views/base/custom_text.dart';

class AuthController extends GetxController {
  //================================> Sign Up <=================================
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNumCtrl = TextEditingController();
  final TextEditingController dateOfBirthCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();
  String? selectedGender;
  RxString selectedModes = ''.obs;
  RxList<String> selectedOptions = <String>[].obs;
  var signUpLoading = false.obs;
  var token = "";

  handleSignUp() async {
    signUpLoading(true);
    Map<String, dynamic> body = {
      "firstName": firstNameCtrl.text.trim(),
      "lastName": lastNameCtrl.text.trim(),
      "mode": selectedModes.value,
      "modeOption": selectedOptions.toList(),
      "gender":selectedGender,
      "email": emailCtrl.text.trim(),
      "password": passwordCtrl.text,
     // "fcmToken": "fcmToken..",

    };

    var headers = {'Content-Type': 'application/json'};

    Response response = await ApiClient.postData(
        ApiConstants.signUpEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.toNamed(AppRoutes.otpScreen, parameters: {
        "email": emailCtrl.text.trim(),
        "screenType": "signup",
      });
      firstNameCtrl.clear();
      lastNameCtrl.clear();
      emailCtrl.clear();
      passwordCtrl.clear();
      selectedModes = ''.obs;
      selectedOptions.value = [''].obs;
      selectedGender = '';
      signUpLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      signUpLoading(false);
      update();
    }
  }
  //==========================> Show Calender Function <=======================
  Future<void> pickBirthDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: Colors.black, // Text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
        dateOfBirthCtrl.text = "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";

    }
  }
  String _getMonthName(int month) {
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  //===================> Otp very <=======================
  TextEditingController otpCtrl = TextEditingController();
  var otpLoading = false.obs;
  handleOtpVery(
      {required String email,
        required String otp,
        required String screenType}) async {
    try {
      var body = {'code': otpCtrl.text, 'email': email};
      var headers = {'Content-Type': 'application/json'};
      otpLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.otpEndPoint, jsonEncode(body),
          headers: headers);
      print("============>${response.body} and ${response.statusCode}");
      if (response.statusCode == 200) {
        print('Token=============>${response.body["data"]['attributes']['tokens']['access']['token']}');
        await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['attributes']['tokens']['access']['token']);
        otpCtrl.clear();
        if (screenType == "forgetPasswordScreen") {
          Get.offAllNamed(AppRoutes.resetPasswordScreen,
              parameters: {"email": email});
        } else {
           Get.offAllNamed(AppRoutes.signInScreen, parameters: {"email": email});
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    }
    otpLoading(false);
  }

//=================> Resend otp <=====================
  var resendOtpLoading = false.obs;
  resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {"email": email};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgotPassEndPoint, json.encode(body),
        headers: header);
    print("===> ${response.body}");
    if (response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(
          msg: response.statusText ?? "",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER);
    }
    resendOtpLoading(false);
  }
  //==================================> Sign In <================================
  TextEditingController signInEmailCtrl = TextEditingController();
  TextEditingController signInPassCtrl = TextEditingController();

  var signInLoading = false.obs;
  handleSignIn() async {
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
    signInLoading(true);
    var headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'email': signInEmailCtrl.text.trim(),
      'password': signInPassCtrl.text.trim(),
      'loginType': "emailAndPassword",
      "fcmToken": fcmToken,
     // fcmToken.isNotEmpty?fcmToken:"test",
    };
    Response response = await ApiClient.postData(
        ApiConstants.signInEndPoint, json.encode(body),
        headers: headers);
    print("====> ${response.body}");
    if (response.statusCode == 200) {
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['tokens']['access']['token']);
      await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['user']['id']);
      await PrefsHelper.setString(AppConstants.userImage, response.body['data']['attributes']['user']['profileImage']);
      await PrefsHelper.setString(AppConstants.userName, response.body['data']['attributes']['user']['firstName']);
      await PrefsHelper.setString(AppConstants.userImage, response.body['data']['attributes']['user']['profileImage']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      bool condition = response.body['data']['attributes']['user']['isProfileCompleted'];
      if(!condition){
        Get.offAllNamed(AppRoutes.uploadPhotosScreen, arguments: false);
      } else {
        Get.offAllNamed(AppRoutes.homeScreen);
      }
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      signInEmailCtrl.clear();
      signInPassCtrl.clear();
      signInLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    signInLoading(false);
  }

  //====================> Forgot pass word <=====================
  TextEditingController forgetEmailTextCtrl = TextEditingController();
  var forgotLoading = false.obs;

  handleForget() async {
    forgotLoading(true);
    var body = {
      "email": forgetEmailTextCtrl.text.trim(),
    };
    var headers = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgotPassEndPoint, json.encode(body),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.otpScreen, parameters: {
        "email": forgetEmailTextCtrl.text.trim(),
        "screenType": "forgetPasswordScreen",
      });
      forgetEmailTextCtrl.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    forgotLoading(false);
  }

  //=============================> Set New password <===========================
  var resetPasswordLoading = false.obs;
  resetPassword(String email, String password) async {
    print("=======> $email, and $password");
    resetPasswordLoading(true);
    var body = {"email": email, "password": password};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.resetPassEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            backgroundColor: AppColors.cardColor,
            title: CustomText(text: "Password Reset!", fontSize: 20.sp),
            content: CustomText(
              text: "Your password has been reset successfully.",
              fontSize: 18.sp,
              maxLine: 3,
              textAlign: TextAlign.start,
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                      WidgetStatePropertyAll(AppColors.primaryColor)),
                  onPressed: () {
                    Get.toNamed(AppRoutes.signInScreen);
                  },
                  child: const Text("Ok"))
            ],
          ));
    } else {
      debugPrint("error set password ${response.statusText}");
      Fluttertoast.showToast(
        msg: "${response.statusText}",
      );
    }
    resetPasswordLoading(false);
  }

  //======================> Handle Change password <============================
  var changePassLoading = false.obs;
  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  handleChangePassword(String oldPassword, newPassword) async {
    changePassLoading(true);
    var body = {"oldPassword": oldPassword, "newPassword": newPassword};
    var response =
    await ApiClient.postData(ApiConstants.changePassEndPoint, body);
    print("===============> ${response.body}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.body['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColors.cardLightColor,
          textColor: Colors.black);
      Get.back();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    changePassLoading(false);
  }



  //======================> Google login Info <============================
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  handleGoogleSignIn(BuildContext context) async {
    await _auth.signOut();
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);

      // Firebase Authentication
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
        var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

        Map<String, dynamic> body = {
          'email': '${user.email}',
          "fcmToken": fcmToken ?? "",
          "loginType": 'google'
        };
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        };
        Response response = await ApiClient.postData(ApiConstants.signInEndPoint, jsonEncode(body), headers: headers);
        print("response on google login :${response.body}");

        if (response.statusCode == 200) {
          await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['tokens']['access']['token']);
          await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['user']['id']);
          await PrefsHelper.setString(AppConstants.userName, response.body['data']['attributes']['user']['fullName']);
          bool condition = response.body['data']['attributes']['user']['isProfileCompleted'];

          if(!condition){
            Get.offAllNamed(AppRoutes.uploadPhotosScreen);
          } else {
            await PrefsHelper.setBool(AppConstants.isLogged, true);
            Get.offAllNamed(AppRoutes.homeScreen);
          }
          // Get.offAllNamed(AppRoutes.uploadPhotosScreen);
          update();
        } else {
          ApiChecker.checkApi(response);
          update();
        }
      }
    } else {
      print("Sign in with Google canceled by user.");
    }
  }

  //======================> Facebook login Info <============================
  /*handleFacebookSignIn(String email,String userRole) async {
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    Map<String, dynamic> body = {
      "email": email,
      "fcmToken": fcmToken ?? "",
       "role": userRole,
      "loginType": 3
    };

    var headers = {'Content-Type': 'application/json'};
    Response response = await ApiClient.postData(
      ApiConstants.logInEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      await PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['tokens']['access']['token']);
      await PrefsHelper.setString(AppConstants.userId, response.body['data']['attributes']['user']['id']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      Get.offAllNamed(AppRoutes.homeScreen);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }*/
  }



