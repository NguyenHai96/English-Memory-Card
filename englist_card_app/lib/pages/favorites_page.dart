// ignore_for_file: must_be_immutable

import 'package:english_words/english_words.dart';
import 'package:englist_card_app/models/english_today.dart';
import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:englist_card_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<EnglishToday> favoritesList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    getEnglishToday();
  }

  getEnglishToday() async {
    SharedPreferences sharePrefe = await SharedPreferences.getInstance();
    List<String>? localFavoriteIds =
        sharePrefe.getStringList(ShareKeys.countFavorites) ?? [];
    List<int> listInt = localFavoriteIds.map(int.parse).toList();
    List<EnglishToday> newList = [];
    listInt.forEach(
      (element) {
        newList.add(EnglishToday(noun: nouns[element].toString()));
      },
    );
    setState(() {
      favoritesList = newList.toList();
    });
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
          onTap: () {
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
                leading: const InkWell(
                    child: Icon(Icons.favorite, color: Colors.pinkAccent)),
              ));
        },
      ),
    );
  }
}
