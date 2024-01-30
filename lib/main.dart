import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vs1/navigation/navigate.dart';
import 'package:vs1/style/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Navigate navigate = Navigate();
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        child: MaterialApp(
          theme: ThemeData(
              colorScheme: const ColorScheme.light(primary: colors.main)),
          debugShowCheckedModeBanner: false,
          initialRoute: navigate.initialRoute,
          routes: navigate.route,
        ));
  }
}
