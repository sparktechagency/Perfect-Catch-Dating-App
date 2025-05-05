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
  File? selectedImage;
  RxString imagesPath = ''.obs;
  String title = "Profile Screen";
  String? selectedGender;

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
    var response = await ApiClient.getData(ApiConstants.getPersonalInfoEndPoint);
    print("my response : ${response.body}");
    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(response.body['data']['attributes']['user']);
      profileLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      profileLoading(false);
      update();
    }
  }


  //===============================> Edit Profile Screen <=============================
  final TextEditingController userNameCTRL = TextEditingController();
  final TextEditingController phoneCTRL = TextEditingController();
  final TextEditingController dateBirthCTRL = TextEditingController();
  final TextEditingController locationCTRL = TextEditingController();
  final TextEditingController ageCTRL = TextEditingController();
  final TextEditingController heightCTRL = TextEditingController();
  final TextEditingController marriedCTRL = TextEditingController();
  final TextEditingController religionCTRL = TextEditingController();
  final TextEditingController eduCTRL = TextEditingController();
  final TextEditingController aboutCTRL = TextEditingController();

  //===============================> Image Picker <=============================
  Future pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedImage = File(returnImage.path);
    imagesPath.value = selectedImage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath===========================>:${imagesPath.value}');
    Get.back(); //
  }

  //==========================> Show Calender Function <=======================
  Future<void> pickBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3050),
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
          "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
    }
  }
}
