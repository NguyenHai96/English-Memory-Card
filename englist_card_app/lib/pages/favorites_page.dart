// ignore_for_file: must_be_immutable

import 'package:english_words/english_words.dart';
import 'package:englist_card_app/models/english_today.dart';
import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:englist_card_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatelessWidget {
  List<EnglishToday> favoritesList;
  FavoritesPage({super.key, required this.favoritesList});
  late SharedPreferences _countFavorites;

  getEnglishToday() async {
    SharedPreferences favorites = await SharedPreferences.getInstance();
    int len = favorites.getInt(ShareKeys.keyFavorites) ?? 0;
    List<String> newList = [];
    for (int i = 0; i < len; i++) {
      if (len < 0) {
        return [];
      } else {
        newList.add(nouns[i]);
      }
    }
    ;

    favoritesList = newList
        .map((e) => EnglishToday(
              noun: e,
            ))
        .toList();
  }

  initDefaultValue() async {
    _countFavorites = await SharedPreferences.getInstance();
    int value = _countFavorites.getInt(ShareKeys.countFavorites) ??
        favoritesList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteGray,
        title: Text(
          'Favorites',
          style: AppStyle.getSize(context, AppStyle.englishToday.fontSize)
              .copyWith(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () async {
            _countFavorites = await SharedPreferences.getInstance();
            await _countFavorites.setInt(
                ShareKeys.countFavorites, favoritesList.length);
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: ListView.builder(
        itemCount: favoritesList.length,
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
                  favoritesList[index].noun!,
                  style: AppStyle.getSize(context, AppStyle.h7.fontSize)
                      .copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.favorite,
                  color: favoritesList[index].isFavorite
                      ? Colors.pinkAccent
                      : Colors.grey,
                )),
          );
        },
      ),
    );
  }
}
