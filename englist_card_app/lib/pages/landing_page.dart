import 'package:englist_card_app/pages/home_page.dart';
import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome to',
                style: AppStyle.getSize(context, AppStyle.h3.fontSize),
              ),
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('English',
                    style: AppStyle.getSize(context, AppStyle.h2.fontSize)
                        .copyWith(
                      color: AppColors.blackGray,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Qoutes"',
                    textAlign: TextAlign.right,
                    style: AppStyle.getSize(context, AppStyle.h4.fontSize)
                        .copyWith(height: 0.8),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: RawMaterialButton(
                shape: const CircleBorder(),
                fillColor: AppColors.white,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false);
                },
                child: Image.asset(AppAssets.rightArrow),
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
