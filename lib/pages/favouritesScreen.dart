import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

import '../Components/recipecard.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  List<Map<String, dynamic>> recipes = [];  // Initialize an empty list for recipes

  @override
  void initState() {
    super.initState();
    favouriteRecipesJson(); // Load recipes on initialization
  }

  void sometesting(){

  }

  Future<void> favouriteRecipesJson() async {
    // Load JSON data from assets
    String jsonString = await rootBundle.loadString('assets/favourites/favouriteRecipes.json');
    List<dynamic> jsonData = json.decode(jsonString); // Decode the JSON string
    setState(() {
      recipes = jsonData.map((e) => e as Map<String, dynamic>).toList();  // Convert to List<Map<String, dynamic>>
      print(recipes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("🚧 On the way!")
    );
  }
}

