import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';

class ProfileController extends GetxController {
  RxString profileImagePath = ''.obs;
  File? selectedImage;
  RxString imagesPath = ''.obs;
  String title = "Profile Screen";
  String? selectedGender;
  RxList<String> selectedLanguage = <String>[].obs;
  RxList<String> selectedInterest = <String>[].obs;

  @override
  void onInit() {
    debugPrint("On Init  $title");
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    debugPrint("On onReady  $title");
    super.onReady();
  }

  //=============================> Get Account Data <===============================
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxBool profileLoading = false.obs;
  getProfileData() async {
    profileLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getPersonalInfoEndPoint,
    );
    print("my response : ${response.body}");
    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(
        response.body['data']['attributes']['user'],
      );
      profileLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      profileLoading(false);
      update();
    }
  }

  //===============================> Edit Profile Screen <=============================
  final TextEditingController firstNameCTRL = TextEditingController();
  final TextEditingController lastNameCTRL = TextEditingController();
  final TextEditingController phoneCTRL = TextEditingController();
  final TextEditingController dateBirthCTRL = TextEditingController();
  final TextEditingController locationCTRL = TextEditingController();
  final TextEditingController ageCTRL = TextEditingController();
  final TextEditingController heightCTRL = TextEditingController();
  final TextEditingController weightCTRL = TextEditingController();
  final TextEditingController marriedCTRL = TextEditingController();
  final TextEditingController religionCTRL = TextEditingController();
  final TextEditingController eduCTRL = TextEditingController();
  final TextEditingController aboutCTRL = TextEditingController();

  var updateProfileLoading = false.obs;
  updateProfile() async {
    updateProfileLoading(true);
    Map<String, String> body = {
      'firstName': firstNameCTRL.text,
      'lastName': lastNameCTRL.text,
      'phoneNumber': phoneCTRL.text,
      'dateOfBirth': dateBirthCTRL.text,
      'height': heightCTRL.text,
      'weight': weightCTRL.text,
      'personalStatus': marriedCTRL.text,
      'religion': religionCTRL.text,
      'educationQualification': eduCTRL.text,
      'gender': '$selectedGender',
      //'interested': '${selectedInterest.toList()}',
      'language': '${selectedLanguage.toList()}',
      'bio': aboutCTRL.text,
    };
    List<MultipartBody> multipartBody = [
      MultipartBody('profileImage', File(profileImagePath.value)),
    ];

    var response = await ApiClient.patchMultipartData(
      ApiConstants.updatePersonalInfoEndPoint,
      body,
      multipartBody: multipartBody,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      firstNameCTRL.clear();
      lastNameCTRL.clear();
      phoneCTRL.clear();
      dateBirthCTRL.clear();
      heightCTRL.clear();
      weightCTRL.clear();
      marriedCTRL.clear();
      religionCTRL.clear();
      aboutCTRL.clear();
      profileImagePath.value = '';
      selectedGender = '';
      selectedLanguage.value = [];
      getProfileData();
      updateProfileLoading(false);
      Get.back();
    } else {
      ApiChecker.checkApi(response);
      updateProfileLoading(false);
      update();
    }
  }

  //===============================> Image Picker <=============================
  Future pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedImage = File(returnImage.path);
    profileImagePath.value = selectedImage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath===========================>:${profileImagePath.value}');
    Get.back(); //
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
      dateBirthCTRL.text =
      "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";
    }
  }

  String _getMonthName(int month) {
    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
