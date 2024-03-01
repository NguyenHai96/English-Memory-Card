import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:englist_card_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGray,
      appBar: AppBar(
        backgroundColor: AppColors.whiteGray,
        title: Text(
          'Your Control',
          style: AppStyle.getSize(context, AppStyle.h3.fontSize).copyWith(
            color: AppColors.textColor,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text(
              'How much a number word at once',
              style: AppStyle.getSize(context, AppStyle.h7.fontSize)
                  .copyWith(color: AppColors.textGray),
            ),
            Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyle.getSize(context, AppStyle.h150.fontSize).copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              alignment: Alignment.centerLeft,
              child: Text(
                'slide to set',
                style: AppStyle.getSize(context, AppStyle.h7.fontSize)
                    .copyWith(color: AppColors.textColor),
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
