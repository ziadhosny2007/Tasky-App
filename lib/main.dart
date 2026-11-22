import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/routes/go_routers.dart';
import 'package:tasky/core/themes/app_theme.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasky/generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
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

  bool isAr = false;

  void flageLang() async {
    isAr = await SharedPreferencesAsync().getBool('isAr') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    flage();
    flageLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flage();
    flageLang();
    return MaterialApp.router(
      locale: (isAr) ? Locale('ar') : Locale('en'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: router,
      theme: (isDark) ? AppTheme.dark : AppTheme.light,
    );
  }
}