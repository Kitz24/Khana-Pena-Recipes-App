import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String title;
  final String details;

  RecipeCard({required this.title, required this.details});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the modal when tapping outside the content
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  // Prevent the onTap on the bottom sheet from dismissing it
                },
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.details,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    // Add more widgets as needed to display the recipe
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
