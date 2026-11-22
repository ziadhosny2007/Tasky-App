import 'package:flutter/material.dart';
import 'package:tasky/core/themes/app_colors.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              alignment: .center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: AppColors.highlight,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    offset: Offset(0, 12),
                    color: AppColors.highlight.withAlpha(130),
                  ),
                ],
              ),
              child: Icon(Icons.done),
            ),
          ],
        ),
      ),
    );
  }
}
