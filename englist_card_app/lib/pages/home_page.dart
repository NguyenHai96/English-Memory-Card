// ignore_for_file: collection_methods_unrelated_type

import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:englist_card_app/models/english_today.dart';
import 'package:englist_card_app/pages/all_words_page.dart';
import 'package:englist_card_app/pages/control_page.dart';
import 'package:englist_card_app/pages/favorites_page.dart';
import 'package:englist_card_app/values/app_assets.dart';
import 'package:englist_card_app/values/app_colors.dart';
import 'package:englist_card_app/values/app_styles.dart';
import 'package:englist_card_app/values/share_keys.dart';
import 'package:englist_card_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (!newList.contains(val)) {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<EnglishToday> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((element) {
      newList.add(EnglishToday(
        noun: nouns[element],
        id: element.toString(),
      ));
    });

    setState(() {
      words = newList.toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
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
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: AppColors.primaryColor,
                        elevation: 4,
                        child: InkWell(
                          onDoubleTap: () {},
                          splashColor: const Color.fromARGB(214, 255, 149, 184),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences sharePrefe =
                                          await SharedPreferences.getInstance();
                                      List<String>? localFavoriteIds =
                                          sharePrefe.getStringList(
                                                  ShareKeys.countFavorites) ??
                                              [];
                                      setState(() {
                                        words[index].isFavorite =
                                            !words[index].isFavorite;
                                      });
                                      if (words[index].isFavorite) {
                                        if (!localFavoriteIds
                                            .contains(words[index].id)) {
                                          localFavoriteIds
                                              .add(words[index].id.toString());
                                        }
                                      } else {
                                        if (localFavoriteIds
                                            .contains(words[index].id)) {
                                          localFavoriteIds.remove(
                                              words[index].id.toString());
                                        }
                                      }
                                      await sharePrefe.setStringList(
                                          ShareKeys.countFavorites,
                                          localFavoriteIds);
                                    },
                                    child: Image.asset(
                                      AppAssets.heart,
                                      color: words[index].isFavorite
                                          ? Colors.pinkAccent
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text(
                                      firstLetter,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: FontFamily.sen,
                                          color: AppColors.whiteGray,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppStyle.scaleRatio(context, 96),
                                          shadows: const [
                                            Shadow(
                                                color: Colors.black38,
                                                offset: Offset(3, 6),
                                                blurRadius: 6),
                                          ]),
                                    ),
                                    Expanded(
                                      child: Text(
                                        leftLetter,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: FontFamily.sen,
                                          color: AppColors.whiteGray,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              AppStyle.scaleRatio(context, 50),
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
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
                        ),
                      ),
                    );
                  })),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: SizedBox(
                        height: size.height * 1 / 24,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: ((context, index) {
                                return buildIndicator(
                                    index == _currentIndex, size);
                              })),
                        )),
                  )
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: AppButton(
                    label: 'Favorites',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FavoritesPage()));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: AppButton(
                    label: 'Your control',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ControlPage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
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

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.bottomLeft,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: AppColors.primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AllWordsPage(words: words)));
          },
          splashColor: Colors.black38,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyle.getSize(context, AppStyle.h5.fontSize)
                  .copyWith(color: AppColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
