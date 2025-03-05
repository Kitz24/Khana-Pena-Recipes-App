import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String? urlInput = '';

  // Two API keys are randomly selected (you can add more keys if needed)
  List<String> apiKeys = [
    'AIzaSyCr9uw8WHJI_pcL3GesMuT0AHpM2f7ZWiQ',
    'AIzaSyBpD6YQ9awMU7hfnS4eQ1KHZhAXDCEEKdI'
  ];
  String apiKeyRandomlySelected = '';

  @override
  void initState() {
    super.initState();
    apiKeyRandomlySelected = _getRandomApi();
  }

  String _getRandomApi() {
    final random = Random();
    final apiToBeRandomlySelected = random.nextInt(apiKeys.length);
    return apiKeys[apiToBeRandomlySelected];
  }

  Future<void> checkUrl() async {
    // Initialize the Gemini model
    final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: apiKeyRandomlySelected,
      generationConfig: GenerationConfig(responseMimeType: "application/json"),
    );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Checking URL..."),
    ));

    // Construct a prompt instructing the model to analyze the URL.
    final prompt = Content.text(
        "Please analyze the following URL and determine if it is a phishing website. "
            "Return a JSON object with two keys: "
            "'isPhishing' (a boolean, true if the URL is phishing, false otherwise) and "
            "'explanation' (a string that explains your reasoning).\n\n"
            "URL: $urlInput"
    );

    final response = await model.generateContent([prompt]);

    // Navigate to the result display screen with the generated content.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhishingResultScreen(
          resultData: response.text ?? '{"isPhishing": false, "explanation": "No response received."}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phishing URL Checker"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.security, size: 80, color: Colors.blue),
                const SizedBox(height: 10),
                const Text(
                  "Enter a URL to check for phishing",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      urlInput = text;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'URL',
                    hintText: 'https://example.com',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Check URL'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus(); // Close the keyboard
                    await checkUrl();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhishingResultScreen extends StatelessWidget {
  final String resultData;

  const PhishingResultScreen({required this.resultData, super.key});

  @override
  Widget build(BuildContext context) {
    // Decode the JSON response.
    final data = jsonDecode(resultData);
    final isPhishing = data['isPhishing'] ?? false;
    final explanation = data['explanation'] ?? 'No explanation provided.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Check Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phishing Status:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isPhishing ? "Phishing Detected" : "Not Phishing",
                    style: TextStyle(
                      fontSize: 22,
                      color: isPhishing ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Explanation:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    explanation,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
