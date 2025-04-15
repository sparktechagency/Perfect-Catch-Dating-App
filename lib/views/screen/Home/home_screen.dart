import 'package:flutter/material.dart';
import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(0),
      body: Center(child:  CustomText(text: 'This is Home Screen')),
    );
  }
}
