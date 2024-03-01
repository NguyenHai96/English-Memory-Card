import 'package:auto_size_text/auto_size_text.dart';
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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: words
                .map(
                  (e) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: AutoSizeText(
                      maxLines: 1,
                      e.noun ?? '',
                      style: AppStyle.getSize(context, AppStyle.h3.fontSize)
                          .copyWith(fontWeight: FontWeight.bold, shadows: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3, 6),
                            blurRadius: 6)
                      ]),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
                .toList(),
          )),
    );
  }
}
