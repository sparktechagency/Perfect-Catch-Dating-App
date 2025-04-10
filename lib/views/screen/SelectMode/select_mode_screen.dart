import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/utils/app_colors.dart';
import 'package:perfect_catch_dating_app/utils/app_strings.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({super.key});

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  List<bool> selectedModes = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //==========================> App Bar Section <=======================
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        //==========================> Skip Button <=======================
        title: GestureDetector(
          onTap: () {},
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: AppStrings.skip.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              textDecoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      //==========================> Body Section <=======================
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            children: [
              CustomText(
                text: AppStrings.chooseYourMode.tr,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                bottom: 16.h,
              ),
              Flexible(
                child: CustomText(
                  text: AppStrings.pleaseSelectAnOneOption.tr,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  maxLine: 3,
                ),
              ),
              SizedBox(height: 32.h),
              // Mode Options
              ModeOption(
                title: 'Best Friend',
                description: 'Open Best Friend Mode',
                isSelected: selectedModes[0],
                onChanged: (value) {
                  setState(() {
                    selectedModes[0] = value ?? false; // Handle null
                    if (value != null && value) {
                      selectedModes[1] = false;
                      selectedModes[2] = false;
                    }
                  });
                },
              ),
              ModeOption(
                title: 'Poly',
                description: 'Open Poly Mode',
                isSelected: selectedModes[1],
                onChanged: (value) {
                  setState(() {
                    selectedModes[1] = value ?? false; // Handle null
                    if (value != null && value) {
                      selectedModes[0] = false;
                      selectedModes[2] = false;
                    }
                  });
                },
              ),
              ModeOption(
                title: 'Arrange Marriage',
                description: 'Open Arrange Marriage Mode',
                isSelected: selectedModes[2],
                onChanged: (value) {
                  setState(() {
                    selectedModes[2] = value ?? false; // Handle null
                    if (value != null && value) {
                      selectedModes[0] = false;
                      selectedModes[1] = false;
                    }
                  });
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Proceed if any mode is selected
                  if (selectedModes.contains(true)) {
                    // Handle continue action (e.g., navigate to next screen)
                  } else {
                    // Show a message that user must select a mode
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a mode to continue')),
                    );
                  }
                },
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1EB5BC), // Continue button color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModeOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final ValueChanged<bool?> onChanged; // Use nullable bool for Checkbox

  ModeOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Color(0xFF1EB5BC) : Colors.grey,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged, // This now accepts bool?
            activeColor: Color(0xFF1EB5BC),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
