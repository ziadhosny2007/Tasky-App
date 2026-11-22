import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/features/app_section/cubit/app_section_cubit.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/screens/claendar.dart';
import 'package:tasky/screens/home.dart';
import 'package:tasky/screens/profile.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key});

  static const List<Widget> pages = [Home(), Claendar(), Profile()];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppSectionCubit>();
    final l10n = S.of(context);

    return BlocBuilder<AppSectionCubit, AppSectionState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.index],
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
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.house, size: 24),
                activeIcon: const Icon(CupertinoIcons.house_fill, size: 24),
                label: l10n.navToday,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.calendar, size: 24),
                activeIcon: const Icon(CupertinoIcons.calendar_today, size: 24),
                label: l10n.navCalendar,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.person, size: 24),
                activeIcon: const Icon(CupertinoIcons.person_fill, size: 24),
                label: l10n.navProfile,
              ),
            ],
          ),
        );
      },
    );
  }
}