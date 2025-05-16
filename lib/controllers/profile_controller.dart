import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
import 'package:perfect_catch_dating_app/utils/app_constants.dart';
import '../models/profile_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';
import '../views/base/custom_text.dart';

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
      'about': aboutCTRL.text,
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
      await PrefsHelper.setString(AppConstants.userImage, response.body['data']['attributes']['profileImage']);
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
  //==========================> Show Height Function <=======================
  Future<void> pickHeight(BuildContext context) async {
    int? selectedFeet;
    int? selectedInches;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title:  CustomText(text: 'Select Your Height'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //==========================> Feet Dropdown <===========================
                  DropdownButton<int>(
                    hint: const Text('Feet'),
                    value: selectedFeet,
                    items: List.generate(8, (index) => index + 1)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: CustomText(text: '$value ft'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFeet = value;
                      });
                    },
                  ),
                  SizedBox(width: 16.w),
                  Divider(thickness: 4.4, color: AppColors.borderColor),
                  //==========================> Inches Dropdown <====================
                  DropdownButton<int>(
                    hint: const Text('Inches'),
                    value: selectedInches,
                    items: List.generate(12, (index) => index)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: CustomText(text: '$value in'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedInches = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedFeet != null && selectedInches != null) {
                  heightCTRL.text = '$selectedFeet\' $selectedInches"';
                  Navigator.of(context).pop();
                }
              },
              child: CustomText (text: 'OK'),
            ),
          ],
        );
      },
    );
  }

  //==========================> Show Weight Function <=======================
  Future<void> pickWeight(BuildContext context) async {
    int? selectedWeight;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Select Your Weight'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<int>(
                hint:  CustomText(text: 'select weight'),
                value: selectedWeight,
                items: List.generate(201, (index) => index + 1)
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: CustomText(text: '$value'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWeight = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedWeight != null) {
                  weightCTRL.text = '$selectedWeight';
                  Navigator.of(context).pop();
                }
              },
              child: CustomText(text: 'OK'),
            ),
          ],
        );
      },
    );
  }

  //==========================> Show Marital Status Function <=======================
  Future<void> pickMaritalStatus(BuildContext context) async {
    String? selectedStatus;

    const List<String> options = ['Single', 'Married', 'Unmarried'];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Select Your Marital Status'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                hint: CustomText(text: 'Select status'),
                value: selectedStatus,
                items: options.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: CustomText(text: status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedStatus != null) {
                  marriedCTRL.text = selectedStatus!;
                  Navigator.of(context).pop();
                }
              },
              child: CustomText(text: 'OK'),
            ),
          ],
        );
      },
    );
  }

//==========================> Show Religion Function <=======================
  Future<void> pickReligion(BuildContext context) async {
    String? selectedReligion;
    const List<String> religions = [
      'Islam',
      'Christianity',
      'Hinduism',
      'Buddhism',
      'Sikhism',
      'Judaism',
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Select Your Religion'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                hint: CustomText(text: 'Select religion'),
                value: selectedReligion,
                items: religions.map((String religion) {
                  return DropdownMenuItem<String>(
                    value: religion,
                    child: CustomText(text: religion),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReligion = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedReligion != null) {
                  religionCTRL.text = selectedReligion!;
                  Navigator.of(context).pop();
                }
              },
              child: CustomText(text: 'OK'),
            ),
          ],
        );
      },
    );
  }
//==========================> Show Education Function <=======================
 /* Future<void> pickEducation(BuildContext context) async {
    String? selectedEducation;

    const List<String> educationOptions = [
      'High school',
      'Trade/tech school',
      'In college',
      'Undergraduate degree',
      'In grad school',
      'Graduate degree',
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Select Your Education'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                hint: CustomText(text: 'Select education'),
                value: selectedEducation,
                isExpanded: true,
                items: educationOptions.map((String education) {
                  return DropdownMenuItem<String>(
                    value: education,
                    child: CustomText(text: education),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEducation = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CustomText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedEducation != null) {
                  eduCTRL.text = selectedEducation!;
                  Navigator.of(context).pop();
                }
              },
              child: CustomText(text: 'OK'),
            ),
          ],
        );
      },
    );
  }*/
  Future<void> pickEducation(BuildContext context) async {
    String? selectedEducation;

    const List<String> educationOptions = [
      'High school',
      'Trade/tech school',
      'In college',
      'Undergraduate degree',
      'In grad school',
      'Graduate degree',
    ];

    await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16.h,
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                  text: 'Select Your Education',
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 300.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: educationOptions.length,
                      itemBuilder: (context, index) {
                        final option = educationOptions[index];
                        return RadioListTile<String>(
                          title: CustomText(text: option, textAlign: TextAlign.start,),
                          value: option,
                          groupValue: selectedEducation,
                          onChanged: (value) {
                            setState(() {
                              selectedEducation = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: CustomText(text: 'Cancel'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: selectedEducation == null
                            ? null
                            : () {
                          eduCTRL.text = selectedEducation!;
                          Navigator.of(context).pop();
                        },
                        child: CustomText(text: 'OK'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
