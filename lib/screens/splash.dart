import 'package:flutter/material.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double value = 0;

  void loading() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 200), () {
        value += 0.1;
      });
      setState(() {});
    }
    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void initState() {
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splash,

      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: 24,
          children: [
            Container(
              alignment: .center,
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: AppColors.highlight,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    offset: Offset(0, 12),
                    color: AppColors.highlight.withAlpha(130),
                  ),
                ],
              ),
              child: Icon(Icons.done, size: 48, color: AppColors.highlight2),
            ),
            Text(
              "Tasky",
              style: TextStyle(
                fontSize: 34,
                fontWeight: .bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              height: 4,
              width: 140,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.highlight2,
                value: value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
