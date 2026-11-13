import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/features/app_section/cubit/app_section_cubit.dart';
import 'package:tasky/screens/claendar.dart';
import 'package:tasky/screens/home.dart';
import 'package:tasky/screens/profile.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSectionCubit>();

    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          cubit.getIndex(value);
        },
        children: const [Home(), Claendar(), Profile()],
      ),
      bottomNavigationBar: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (value) {
              cubit.getIndex(value);

              controller.animateToPage(
                value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.highlight,
            unselectedItemColor: const Color(0xff6E6B7B),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house, size: 24),
                activeIcon: Icon(CupertinoIcons.house_fill, size: 24),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar, size: 24),
                activeIcon: Icon(CupertinoIcons.calendar_today, size: 24),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person, size: 24),
                activeIcon: Icon(CupertinoIcons.person_fill, size: 24),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
