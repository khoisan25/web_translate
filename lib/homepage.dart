import 'package:flutter/material.dart';

import 'core/desktop_body.dart';
import 'core/mobile_body.dart';
import 'core/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001845),
      body: ResponsiveLayout(
        mobileBody: const MyMobileBody(),
        desktopBody: const MyDesktopBody(),
      ),
    );
  }
}
