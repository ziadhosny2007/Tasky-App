import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/features/app_section/cubit/app_section_cubit.dart';
import 'package:tasky/features/app_section/view/app_section.dart';
import 'package:tasky/screens/add_task.dart';
import 'package:tasky/screens/home.dart';
import 'package:tasky/screens/onboarding.dart';
import 'package:tasky/screens/splash.dart';

GoRouter router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(path: "/splash", builder: (context, state) => const Splash()),
    GoRoute(
      path: "/appSection",
      builder: (context, state) => BlocProvider(
        create: (context) => AppSectionCubit(),
        child: AppSection(),
      ),
    ),
    GoRoute(
      path: "/onboarding",
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(path: "/home", builder: (context, state) => const Home()),
    GoRoute(path: "/add-task", builder: (context, state) => const AddTask()),
  ],
);
