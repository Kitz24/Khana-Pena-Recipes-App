import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String title;
  final String ingredients;
  final String instructions;

  RecipeCard({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

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
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Added vertical padding for separation between sections
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text(
                            "Ingredients:",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Bold and slightly smaller header for better aesthetics
                          ),
                          SizedBox(height: 10), // Space between header and content
                          ...widget.ingredients.split('\n').map((ingredient) => Padding( // Split by new lines
                            padding: const EdgeInsets.symmetric(vertical: 4.0), // Padding between each ingredient
                            child: Text(
                              ingredient.trim(), // Trim whitespace for better formatting
                              style: TextStyle(fontSize: 18, height: 1.5), // Adjusted line height for better readability
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Added vertical padding for separation between sections
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text(
                            "Instructions:",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Bold and slightly smaller header for better aesthetics
                          ),
                          SizedBox(height: 10), // Space between header and content
                          ...widget.instructions.split('\n').map((instruction) => Padding( // Split by new lines
                            padding: const EdgeInsets.symmetric(vertical: 4.0), // Padding between each instruction step
                            child: Text(
                              instruction.trim(), // Trim whitespace for better formatting
                              style: TextStyle(fontSize: 18, height: 1.5), // Adjusted line height for better readability
                            ),
                          )),
                        ],
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