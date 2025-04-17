import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController _locationCTRL = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _maxDistance = 36;
  double _minAge = 18;
  double _maxAge = 36;
  String? selectedGender;
  String? selectedMatch;

  final List<String> genderOptions = ['Male', 'Female'];
  List<String> matchOptions = [];
  Map<String, String> matchIdMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.filters.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //=======================> Gender Dropdown <==================
                CustomText(
                  text: AppStrings.gender.tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  bottom: 8.h,
                ),
                _dropdownField(genderOptions, selectedGender, (value) {
                  setState(() {
                    selectedGender = value;
                  });
                }, 'Gender'.tr),
                SizedBox(height: 16.h),
                //=======================> Location  <==================
                CustomText(
                  text: AppStrings.location.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  bottom: 8.h,
                ),
                CustomTextField(
                  controller: _locationCTRL,
                  hintText: 'Enter Location'.tr,
                  borderColor: AppColors.primaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your location".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                //=======================> Age Range Slider <==================
                CustomText(
                  text: AppStrings.howOldAreThey.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  bottom: 12.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.between18And36.tr,
                          fontWeight: FontWeight.w500,
                          bottom: 8.h,
                        ),
                        _ageSlider(),
                        _rangeLabels('Minimum', _minAge, 'Maximum', _maxAge),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                //=======================> Distance Slider <==================
                CustomText(
                  text: AppStrings.distance.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  bottom: 12.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.between5KMand36KM.tr,
                          fontWeight: FontWeight.w500,
                          bottom: 8.h,
                        ),
                        _distanceSlider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Distance'.tr,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.w,
                                ),
                              ),
                              child: Text(
                                _maxDistance.toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                //====================> Find Friends Button <=====================
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  text: AppStrings.apply.tr,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //============================> Distance Slider <===============================
  Widget _distanceSlider() {
    return Slider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      value: _maxDistance,
      min: 0,
      max: 200,
      divisions: 200,
      label: _maxDistance.toStringAsFixed(0),
      onChanged: (value) {
        setState(() {
          _maxDistance = value;
        });
      },
    );
  }

  //============================> Age Slider <===============================
  Widget _ageSlider() {
    return RangeSlider(
      activeColor: AppColors.primaryColor,
      inactiveColor: AppColors.greyColor,
      values: RangeValues(_minAge, _maxAge),
      min: 18,
      max: 80,
      divisions: 80,
      labels: RangeLabels(
        _minAge.toStringAsFixed(0),
        _maxAge.toStringAsFixed(0),
      ),
      onChanged: (values) {
        setState(() {
          _minAge = values.start;
          _maxAge = values.end;
        });
      },
    );
  }

  //============================> Dropdown Field <===============================
  _dropdownField(
    List<String> options,
    String? selectedValue,
    Function(String?) onChanged,
    String hint,
  ) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
      items:
          options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.black)),
                ),
              )
              .toList(),
      onChanged: onChanged,
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  //============================> Range Labels <===============================
  Widget _rangeLabels(
    String label1,
    double value1,
    String label2,
    double value2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_rangeTag(label1, value1), _rangeTag(label2, value2)],
    );
  }

  Widget _rangeTag(String label, double value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp)),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue, width: 1.w),
          ),
          child: Text(
            value.toStringAsFixed(0),
            style: TextStyle(fontSize: 14.sp, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
