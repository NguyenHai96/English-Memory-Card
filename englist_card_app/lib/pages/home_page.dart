import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGray,
      appBar: AppBar(
        backgroundColor: AppColors.whiteGray,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyle.getSize(context, AppStyle.h4.fontSize).copyWith(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {},
          child: Image.asset(AppAssets.menu),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Exchange');
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }
}
