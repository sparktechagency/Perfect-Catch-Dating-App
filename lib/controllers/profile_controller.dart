import 'dart:convert';
import 'dart:io';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country/flutter_country.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      'interested':jsonEncode(selectedInterest),
      'language': selectedLanguage.join(', '),
      'about': aboutCTRL.text,
    };

    for(final MapEntry<String, String> val in body.entries){
      if(val.value.isEmpty){

        return Fluttertoast.showToast(msg: 'You can not leave empty : ${val.key}'.tr);
      }
    }
    updateProfileLoading(true);


    Response response;

    if(profileImagePath.value.isNotEmpty){
      List<MultipartBody> multipartBody = [
        MultipartBody('profileImage', File(profileImagePath.value)),
      ];

      response = await ApiClient.patchMultipartData(
        ApiConstants.updatePersonalInfoEndPoint,
        body,
        multipartBody: multipartBody,
      );
    }
    else{
      response = await ApiClient.patchData(
        ApiConstants.updatePersonalInfoEndPoint,
        jsonEncode(body),
      );
    }

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
      selectedInterest.value = [];
      selectedLanguage.value = [];
      updateProfileLoading(false);
      Get.back();
      getProfileData();
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
  //==========================> Height Function <=======================
  Future<void> pickHeight(BuildContext context) async {
    int? selectedFeet = heightCTRL.text.isNotEmpty
        ? int.tryParse(heightCTRL.text.split('').first)
        : null;

    final feetOptions = List<int>.generate(12, (i) => i + 1); // 1 to 8 feet

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Select Your Height'),
              SizedBox(height: 12.h),
              SizedBox(
                height: 300.h,
                child: ListView(
                  children: feetOptions.map((feet) => RadioListTile<int>(
                    title: CustomText(text: '$feet ft', textAlign: TextAlign.start),
                    value: feet,
                    groupValue: selectedFeet,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.primaryColor; // Selected color
                      }
                      return Colors.grey;
                    }),
                    onChanged: (val){
                      heightCTRL.text = val.toString();
                      setState(() => selectedFeet = val);
                    },
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: CustomText(text: 'Cancel')),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: selectedFeet == null
                        ? null
                        : () {
                      heightCTRL.text = "$selectedFeet";
                      Navigator.pop(context);
                    },
                    child: CustomText(text: 'OK'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  //==========================> Weight Function <=======================
  Future<void> pickWeight(BuildContext context) async {
    int? selectedWeight = weightCTRL.text.isNotEmpty ? int.tryParse(weightCTRL.text) : null;

    final weights = List<int>.generate(201, (i) => i + 1); // 1 to 201

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Select Your Weight'),
              SizedBox(height: 12.h),
              SizedBox(
                height: 300.h,
                child: ListView(
                  children: weights.map((weight) => RadioListTile<int>(
                    title: CustomText(text: '$weight', textAlign: TextAlign.start),
                    value: weight,
                    groupValue: selectedWeight,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.primaryColor; // Selected color
                      }
                      return Colors.grey;
                    }),
                    onChanged: (val) {
                      setState(() => selectedWeight = val);
                  },
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: CustomText(text: 'Cancel'),
                  ),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: selectedWeight == null
                        ? null
                        : () {
                      weightCTRL.text = selectedWeight.toString();
                      Navigator.pop(context);
                    },
                    child: CustomText(text: 'OK'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  //==========================> Marital Status Function <=======================
  Future<void> pickMaritalStatus(BuildContext context) async {
    String? selected = marriedCTRL.text.isNotEmpty ? marriedCTRL.text : null;
    const options = ['Single', 'Married', 'Unmarried'];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16.h, left: 16.w, right: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Select Your Marital Status'),
              SizedBox(height: 12.h),
              SizedBox(
                height: 200.h,
                child: ListView(
                  children: options.map((status) => RadioListTile<String>(
                    title: CustomText(text: status, textAlign: TextAlign.start),
                    value: status,
                    groupValue: selected,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.primaryColor; // Selected color
                      }
                      return Colors.grey;
                    }),
                    onChanged: (val) {
                      marriedCTRL.text = val!;
                      setState(() => selected = val);
                    },
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: CustomText(text: 'Cancel')),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: selected == null ? null : () {
                      marriedCTRL.text = selected!;
                      Navigator.pop(context);
                    },
                    child: CustomText(text: 'OK'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }


//==========================> Religion Function <=======================
  Future<void> pickReligion(BuildContext context) async {
    String? selected = religionCTRL.text.isNotEmpty ? religionCTRL.text : null;
    const religions = [
      'Islam',
      'Christianity',
      'Hinduism',
      'Buddhism',
      'Sikhism',
      'Judaism',
    ];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16.h, left: 16.w, right: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Select Your Marital Status'),
              SizedBox(height: 12.h),
              SizedBox(
                height: 200.h,
                child: ListView(
                  children: religions.map((status) => RadioListTile<String>(
                    title: CustomText(text: status, textAlign: TextAlign.start),
                    value: status,
                    groupValue: selected,
                    activeColor: AppColors.primaryColor,
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.primaryColor; // Selected color
                      }
                      return Colors.grey;
                    }),
                    onChanged: (val) {
                      religionCTRL.text = val!;
                      setState(() => selected = val);
                    },
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: CustomText(text: 'Cancel')),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: selected == null ? null : () {
                      religionCTRL.text = selected!;
                      Navigator.pop(context);
                    },
                    child: CustomText(text: 'OK'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

//==========================> Education Function <=======================
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
                          activeColor: AppColors.primaryColor,
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.primaryColor; // Selected color
                            }
                            return Colors.grey;
                          }),
                          title: CustomText(text: option, textAlign: TextAlign.start,),
                          value: option,
                          groupValue: selectedEducation,
                          onChanged: (value) {
                            setState(() {
                              eduCTRL.text = value!;
                              selectedEducation = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
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
                  SizedBox(height: 16.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

//==========================> Interest Function <=======================
  Future<void> pickInterest(BuildContext context) async {
    List<String> allInterests = [
      'Reading',
      'Photography',
      'Gaming',
      'Music',
      'Travel',
      'Painting',
      'Politics',
      'Cooking',
      'Pets',
      'Charity',
      'Sports',
      'Fashion',
    ];

    List<String> selectedInterests = selectedInterest.isNotEmpty
        ? selectedInterest.map((e) => e.trim()).toList()
        : [];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Select Interests'),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 400.h,
                  child: ListView.builder(
                    itemCount: allInterests.length,
                    itemBuilder: (context, index) {
                      final interest = allInterests[index];
                      final isSelected = selectedInterests.contains(interest);

                      return CheckboxListTile(
                        title: Row(
                          children: [
                            Flexible(
                              child: CustomText(
                                text: interest,
                                maxLine: 2,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        value: isSelected,
                        activeColor: AppColors.primaryColor,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.primaryColor; // Selected color
                          }
                          return Colors.grey;
                        }),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              if (!selectedInterests.contains(interest)) {
                                selectedInterests.add(interest);
                              }
                            } else {
                              selectedInterests.remove(interest);
                            }
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
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(text: 'Cancel'),
                    ),
                    SizedBox(width: 8.w),
                    TextButton(
                      onPressed: () {
                        selectedInterest.assignAll(selectedInterests);
                        Navigator.pop(context);
                      },
                      child: CustomText(text: 'OK'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        },
      ),
    );
  }


//==========================> Language Function <=======================
  Future<void> pickCountries(BuildContext context) async {
    await CountryCodes.init();
    final allCountries = CountryCodes.countryCodes();
    List<String> selectedCountries = selectedLanguage.isNotEmpty
        ? selectedLanguage.map((e) => e.trim()).toList()
        : [];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Select Countries'),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 400.h,
                  child: ListView.builder(
                    itemCount: allCountries.length,
                    itemBuilder: (context, index) {
                      final country = allCountries[index];
                      final countryName = country.name ?? 'Unknown';
                      final isSelected = selectedCountries.contains(countryName);

                      return CheckboxListTile(
                        title: Row(
                          children: [
                            Flexible(
                              child: CustomText(text: countryName, maxLine: 2,
                              textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                        value: isSelected,
                        activeColor: AppColors.primaryColor,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.primaryColor; // Selected color
                          }
                          return Colors.grey;
                        }),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              if (!selectedCountries.contains(countryName)) {
                                selectedCountries.add(countryName);
                              }
                            } else {
                              selectedCountries.remove(countryName);
                            }
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
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(text: 'Cancel'),
                    ),
                    SizedBox(width: 8.w),
                    TextButton(
                      onPressed: () {
                        selectedLanguage.assignAll(selectedCountries);
                        Navigator.pop(context);
                      },
                      child: CustomText(text: 'OK'),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        },
      ),
    );
  }


}
