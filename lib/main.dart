import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Strady',
          theme: ThemeData(
            fontFamily: "Poppins",
          ),
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            "/home": (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
