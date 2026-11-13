import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/app_section/cubit/app_section_cubit.dart';
import 'package:tasky/features/app_section/view/app_section.dart';
import 'package:tasky/screens/add_task.dart';
import 'package:tasky/screens/home.dart';
import 'package:tasky/screens/onboarding.dart';
import 'package:tasky/screens/splash.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String appSection = '/appSection';

  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String addTask = '/add-task';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const Splash(),
    onboarding: (context) => const Onboarding(),
    home: (context) => Home(),
    appSection: (context) => BlocProvider(
      create: (context) => AppSectionCubit(),
      child: AppSection(),
    ),
    addTask:(context)=>AddTask()
  };
}
