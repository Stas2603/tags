import 'package:flutter/material.dart';
import 'package:ubrainians_test/src/main_screen/main_screen_view_dynamic.dart';

class UbrainiansTest extends StatelessWidget {
  const UbrainiansTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreenViewDynamic(),
    );
  }
}
