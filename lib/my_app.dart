import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/common/constants/color_constants.dart';
import 'package:study_buddy/views/screens/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard when tapping outside of text fields.
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Study Buddy',
        theme: ThemeData(
          // appBarTheme: AppBarTheme(
          //   backgroundColor: ColorConstants.theIndigo,
          //   foregroundColor: ColorConstants.theWhite,
          // ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstants.theIndigo,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
