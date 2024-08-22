import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khana_peena_recipes/Components/searchBar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String? displayText = '';
  String? value = '';

  Future<void> func() async {
    final model = GenerativeModel(
        model: "gemini-1.5-flash-latest",
        apiKey: "AIzaSyBpD6YQ9awMU7hfnS4eQ1KHZhAXDCEEKdI",
        generationConfig: GenerationConfig(responseMimeType: "application/json")
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Sending Message"),
    ));

    final response = await model.generateContent([
      Content.text("You will be asked to give"
          " the recipe of any food in this world, "
          "you must ensure there is a title, ingredients and "
          "instructions for the food. You can also give tips or notes"
          " at the end. Recipe for $value"),
    ]);
    setState(() {
      displayText = response.text ?? 'No content generated';
    });
    print(displayText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Icon(Icons.fastfood_outlined, color: Colors.black,),
              Text(
                "Create Your Own Recipe!",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20,),
              Text("Just type the Food Name and get the Recipe!"),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  setState(() {
                    value = text;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                  hintText: 'Enter Food Name',
                ),
              ),
              ElevatedButton(
                child: Text('Click me'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red, // button color
                  backgroundColor: Colors.white, // text color
                  elevation: 10, // elevation
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)), // shape
                ),
                onPressed: () async {
                  // Close the keyboard
                  FocusScope.of(context).unfocus();

                  // Call the func to generate content
                  await func();
                },
              ),
              // Removed commented SelectableText

              // Add the following code to display the recipe information in a card format
                if (displayText != null && displayText!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red.shade400, width: 6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlitteryHeading('Title'),
                          SizedBox(height: 10),
                          Text(
                            parseJsonForTitle(displayText!),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Para',
                              letterSpacing: -0.5,
                              wordSpacing: 5,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          GlitteryHeading('Ingredients'),
                          SizedBox(height: 20),
                          Text(
                            parseJsonForIngredients(displayText!),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Para',
                              letterSpacing: -0.5,
                              wordSpacing: 5,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          GlitteryHeading('Instructions'),
                          SizedBox(height: 20,),
                          Text(
                            parseJsonForInstructions(displayText!),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Para',
                                letterSpacing: -0.5,
                                wordSpacing: 5,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ...parseJsonForOtherSections(displayText!),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods to parse JSON for title, ingredients, instructions, and other sections
  String parseJsonForTitle(String jsonString) {
    final data = jsonDecode(jsonString);
    return data['title'] ?? '';
  }

  String parseJsonForIngredients(String jsonString) {
    final data = jsonDecode(jsonString);
    final ingredients = data['ingredients']?.cast<String>();
    return ingredients != null ? ingredients.map((i) => '- $i').join('\n') : ''; // Join ingredients with newline and hyphen
  }

  String parseJsonForInstructions(String jsonString) {
    final data = jsonDecode(jsonString);
    final instructions = data['instructions']?.cast<String>();
    return instructions != null ? instructions.map((i) => '- $i').join('\n\n') : ''; // Join ingredients with newline and hyphen
  }

  List<Widget> parseJsonForOtherSections(String jsonString) {
    final data = jsonDecode(jsonString);
    final List<Widget> otherSections = [];
    data.forEach((key, value) {
      if (key != 'title' && key != 'ingredients' && key != 'instructions') {
        otherSections.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              GlitteryHeading(capitalize(key)),
              SizedBox(height: 10),
              Text(
                value is List ? value.join('\n\n - ') : value.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Para',
                  letterSpacing: -0.5,
                  wordSpacing: 4,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }
    });
    return otherSections;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class GlitteryHeading extends StatelessWidget {
  final String text;

  GlitteryHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.star, color: Colors.red, size: 16),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'Bocchi',
              color: Colors.red,
              shadows: [
                Shadow(
                  blurRadius: 1.0,
                  color: Colors.pink,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Icon(FontAwesomeIcons.star, color: Colors.red, size: 16),
        ],
      ),
    );
  }
}
