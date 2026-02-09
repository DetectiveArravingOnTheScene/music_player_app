import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'main_content.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainContent();
  }
}
