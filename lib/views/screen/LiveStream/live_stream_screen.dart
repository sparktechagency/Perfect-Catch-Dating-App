import 'package:flutter/material.dart';

import '../../base/bottom_menu..dart';
import '../../base/custom_text.dart';

class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(2),
      body: Center(child:  CustomText(text: 'This is Live Stream Screen')),
    );
  }
}
