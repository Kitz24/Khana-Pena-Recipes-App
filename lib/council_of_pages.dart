import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khana_peena_recipes/Components/searchBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khana_peena_recipes/pages/createRecipe.dart';
import 'package:khana_peena_recipes/pages/homescreen.dart';
import 'package:khana_peena_recipes/pages/tokensScreen.dart';
import 'package:like_button/like_button.dart';
import 'package:khana_peena_recipes/pages/favouritesScreen.dart';

class CouncilOfPages extends StatefulWidget {
  const CouncilOfPages({super.key});

  @override
  State<CouncilOfPages> createState() => _CouncilOfPagesState();
}

class _CouncilOfPagesState extends State<CouncilOfPages> {
  int _selectedIndex = 0;
  int _favouriteIndex = -1; // Initialize to -1 (not favourited)

  PageController _pageController = PageController();

  List<String> category = [
    "Chicken",
    "Biryani",
    "Pizza",
    "Rotis",
    "Burger",
    "North Indian",
    "Noodles",
    "South Indian",
  ];

  String? displayText = '';
  String? value = '';


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Color(0xFFB2675E),
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: <Widget>[
              HomeScreen(category: category),
              FavouritesScreen(),
              CreateScreen(),
              TokensScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GNav(
                gap: 7,
                tabBackgroundColor: Colors.grey.shade300,
                padding: EdgeInsets.all(14),
                rippleColor: Colors.grey,
                backgroundColor: Colors.white,
                onTabChange: _onItemTapped,
                selectedIndex: _selectedIndex,
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: "Home"),
                  GButton(icon: Icons.favorite_border_rounded, text: "Favourites"),
                  GButton(icon: Icons.create_outlined, text: "Create"),
                  GButton(icon: Icons.monetization_on_outlined, text: "Tokens"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


