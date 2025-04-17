import 'package:flutter/material.dart';
import 'package:perfect_catch_dating_app/utils/app_images.dart';

import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(2),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.demo), fit: BoxFit.cover)
        ),
      ),
    );
  }
}
