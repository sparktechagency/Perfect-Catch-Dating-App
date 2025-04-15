import 'package:flutter/material.dart';
import 'package:perfect_catch_dating_app/views/base/custom_text.dart';
import '../../base/bottom_menu..dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(1),
      body: Center(child:  CustomText(text: 'This is Matches Screen')),
    );
  }
}
