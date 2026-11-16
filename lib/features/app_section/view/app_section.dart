import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/features/app_section/cubit/app_section_cubit.dart';
import 'package:tasky/screens/claendar.dart';
import 'package:tasky/screens/home.dart';
import 'package:tasky/screens/profile.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key});

  static const List<Widget> pages = [Home(), Claendar(), Profile()];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSectionCubit>();

    return BlocBuilder<AppSectionCubit, AppSectionState>(
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragEnd: (details) {
              final v = details.primaryVelocity ?? 0;
              if (v < -300 && state.index < pages.length - 1) {
                cubit.getIndex(
                  state.index + 1,
                ); // سحب لليسار -> الصفحة اللي بعدها
              } else if (v > 300 && state.index > 0) {
                cubit.getIndex(
                  state.index - 1,
                ); // سحب لليمين -> الصفحة اللي قبلها
              }
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(state.index),
                child: pages[state.index],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: cubit.getIndex,
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
          ),
        );
      },
    );
  }
}
