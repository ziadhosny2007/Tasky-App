import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
            LoadingWidget(sharedPreferences: SharedPreferencesAsync()),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoadingWidget extends StatefulWidget {
  LoadingWidget({super.key, required this.sharedPreferences});
  SharedPreferencesAsync sharedPreferences;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  double value = 0;

  void loading() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 100), () {
        value += 0.1;
      });
      setState(() {});
    }
    bool? flage = await widget.sharedPreferences.getBool("isFirst");
    if (flage == false) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.appSection);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  @override
  void initState() {
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      width: 140,
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.highlight2,
        value: value,
      ),
    );
  }
}
