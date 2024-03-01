import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:englist_card_app/models/english_today.dart';
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
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() {
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: 5, max: nouns.length);
    rans.forEach((element) {
      newList.add(nouns[element]);
    });

    words = newList
        .map((e) => EnglishToday(
              noun: e,
            ))
        .toList();
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteGray,
      appBar: AppBar(
        backgroundColor: AppColors.whiteGray,
        title: Text(
          'English today',
          style: AppStyle.getSize(context, AppStyle.englishToday.fontSize)
              .copyWith(
            color: Colors.black,
          ),
        ),
        // leading: InkWell(
        //   onTap: () {},
        //   child: Image.asset(AppAssets.menu),
        // ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: size.height * 1 / 10,
              alignment: Alignment.centerLeft,
              child: Text(
                '"It is amazing how complete is the delusion that beauty is goodness.',
                style: AppStyle.getSize(context, AppStyle.h5.fontSize)
                    .copyWith(color: Colors.black),
              ),
            ),
            Container(
              height: size.height * 3 / 5,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      //Hàm setState, cập nhật dữ liệu, tức biến nào sử dụng biến _currentIndex thì sẽ render lại
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: ((context, index) {
                    String firstLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0, 1);
                    String leftLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(3, 6),
                                  blurRadius: 6)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(AppAssets.heart),
                            ),
                            RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: firstLetter,
                                    style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            AppStyle.scaleRatio(context, 96),
                                        shadows: const [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6),
                                        ]),
                                    children: [
                                      TextSpan(
                                        text: leftLetter,
                                        style: TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppStyle.scaleRatio(
                                                context, 54)),
                                      ),
                                    ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                  '"Think of all the beauty still left around you and be happy."',
                                  style: AppStyle.getSize(
                                          context, AppStyle.h4.fontSize)
                                      .copyWith(
                                          color: Colors.black,
                                          letterSpacing: 1)),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ),
            SizedBox(
                height: size.height * 1 / 24,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        return buildIndicator(index == _currentIndex, size);
                      })),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.blueGray,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20),
                child: Text('Your mind',
                    style: AppStyle.getSize(
                      context,
                      AppStyle.h3.fontSize,
                    ).copyWith(color: AppColors.textColor)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.blueGray : AppColors.whiteGray,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
