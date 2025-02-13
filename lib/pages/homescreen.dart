import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();

  void _checkUrl() {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a URL")),
      );
      return;
    }
    // Navigate to the screen that will perform the phishing URL check.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckUrlScreen(url: url),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PhishShield"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.security,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                const Text(
                  " Infinite Security ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Our Decentralized app will ensure you stay protected, Always.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),

                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// This is a placeholder screen that represents where the phishing URL check
/// would take place (e.g. calling the Gemini API and displaying the result).
class CheckUrlScreen extends StatelessWidget {
  final String url;

  const CheckUrlScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // In your real implementation, you would call your Gemini API here
    // and then display the result.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checking URL"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Checking URL:\n$url",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
