import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/routes/go_routers.dart';
import 'package:tasky/core/themes/app_theme.dart';

void main() async {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();
  bool isDark = false;

  void flage() async {
    isDark = await SharedPreferencesAsync().getBool('isDark') ?? false;
        setState(() {});

  }

  @override
  void initState() {
    flage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flage();
    return MaterialApp.router(
      routerConfig: router,
      theme: (isDark) ? AppTheme.dark : AppTheme.light,
    
    );
  }
}
