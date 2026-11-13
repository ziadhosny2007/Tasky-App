import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<Map> list = [
    {
      "icon1": Icons.format_list_bulleted_rounded,
      "title": "Keep every task in its place",
      "des":
          "Sort your to-dos into Work, Personal, Shopping and Health so nothing gets lost.",
      "icon2": Icons.folder_open,
      "btn": "Next",
    },
    {
      "icon1": Icons.flag_outlined,
      "title": "Focus on what matters",
      "des":
          "Mark tasks Low, Medium or High and start your day with the ones that count.",
      "icon2": Icons.electric_bolt_rounded,
      "btn": "Next",
    },
    {
      "icon1": Icons.trending_up_sharp,
      "title": "See your progress grow",
      "des":
          "Watch your daily progress fill up and build a habit of finishing.",
      "icon2": Icons.done,
      "btn": "Get Started",
    },
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.appSection);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: AppColors.highlight,
                fontSize: 15,
                fontWeight: .bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                height: 260,
                width: 260,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipOval(
                        child: Container(
                          alignment: .center,
                          height: 260,
                          width: 260,
                          color: AppColors.highlight.withAlpha(32),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 170,
                            width: 170,
                            decoration: BoxDecoration(
                              color: AppColors.highlight,
                              borderRadius: BorderRadius.circular(48),
                            ),
                            child: Icon(
                              list[selectedIndex]["icon1"],
                              size: 90,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 24,
                          right: 14,
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: AppColors.highlight2,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              list[selectedIndex]["icon2"],
                              size: 34,
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 330,
                child: Text(
                  textAlign: .center,
                  list[selectedIndex]["title"],
                  style: Theme.of(
                    context,
                  ).primaryTextTheme.titleLarge!.copyWith(fontSize: 26),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 330,
                child: Text(
                  textAlign: .center,
                  list[selectedIndex]["des"],
                  style: Theme.of(context).primaryTextTheme.titleLarge!
                      .copyWith(fontSize: 16, color: Color(0xff6E6B7B)),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 110,
          margin: EdgeInsets.symmetric(horizontal: 24),
          alignment: .center,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: selectedIndex,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: AppColors.highlight,
                  dotColor: AppColors.highlight.withAlpha(130),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (selectedIndex < 2) {
                    selectedIndex += 1;
                    setState(() {});
                  } else {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.appSection);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minWidth: 92,
                height: 52,
                color: AppColors.highlight,
                child: Text(
                  list[selectedIndex]["btn"],
                  style: TextStyle(
                    fontWeight: .bold,
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
