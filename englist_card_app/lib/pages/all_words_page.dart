import 'package:englist_card_app/models/english_today.dart';
import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteGray,
        title: Text(
          'English today',
          style: AppStyle.getSize(context, AppStyle.englishToday.fontSize)
              .copyWith(
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: index % 2 == 0
                    ? AppColors.primaryColor
                    : AppColors.whiteGray,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  words[index].noun!,
                  style: AppStyle.getSize(context, AppStyle.h7.fontSize)
                      .copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.favorite,
                  color:
                      words[index].isFavorite ? Colors.pinkAccent : Colors.grey,
                )),
          );
        },
      ),
    );
  }
}
