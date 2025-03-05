import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app_to_foreground/app_to_foreground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';
import 'package:flutter_accessibility_service/accessibility_event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Assume HomeScreen is defined in homescreen.dart.
import 'homescreen.dart';

class AccessibilityExample extends StatefulWidget {
  final VoidCallback? onPermissionNotEnabled;
  const AccessibilityExample({Key? key, this.onPermissionNotEnabled})
      : super(key: key);

  @override
  _AccessibilityExampleState createState() => _AccessibilityExampleState();
}

class _AccessibilityExampleState extends State<AccessibilityExample>
    with WidgetsBindingObserver {
  String? currentUrl;
  bool? isPhishing;
  String? explanation;
  StreamSubscription<AccessibilityEvent>? _subscription;

  // API keys (select one randomly)
  final List<String> apiKeys = [
    'AIzaSyCr9uw8WHJI_pcL3GesMuT0AHpM2f7ZWiQ',
    'AIzaSyBpD6YQ9awMU7hfnS4eQ1KHZhAXDCEEKdI'
  ];
  late String apiKeyRandomlySelected;

  String _getRandomApi() {
    final random = Random();
    return apiKeys[random.nextInt(apiKeys.length)];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    apiKeyRandomlySelected = _getRandomApi();
    _checkAndHandleAccessibilityPermission();

    // Listen to accessibility events from Chrome.
    _subscription =
        FlutterAccessibilityService.accessStream.listen((event) {
          if (event.packageName != null &&
              event.packageName!.contains("com.android.chrome")) {
            final String? text = event.text;
            // Simple check: if the text contains a dot and no spaces, assume it's a URL.
            if (text != null && text.contains('.') && !text.contains(' ')) {
              if (currentUrl != text) {
                setState(() {
                  currentUrl = text;
                });
                _checkUrl();
              }
            }
          }
        });
  }

  Future<void> _checkAndHandleAccessibilityPermission() async {
    final bool isEnabled =
    await FlutterAccessibilityService.isAccessibilityPermissionEnabled();
    if (!isEnabled) {
      // Show a toast and navigate back.
      Fluttertoast.showToast(
        msg: "Enable Infini-Shield",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if (widget.onPermissionNotEnabled != null) {
        widget.onPermissionNotEnabled!();
      }
      await FlutterAccessibilityService.requestAccessibilityPermission();
    } else {
      Fluttertoast.showToast(
        msg: "Working",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _checkUrl() async {
    if (currentUrl == null) return;

    final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: apiKeyRandomlySelected,
      generationConfig: GenerationConfig(responseMimeType: "application/json"),
    );

    final prompt = Content.text(
      "Please analyze the following URL and determine if it is a phishing website. "
          "Return a JSON object with two keys: "
          "'isPhishing' (a boolean, true if the URL is phishing, false otherwise) and "
          "'explanation' (a string that explains your reasoning).\n\n"
          "URL: $currentUrl",
    );

    final response = await model.generateContent([prompt]);
    final responseText = response.text ??
        '{"isPhishing": false, "explanation": "No response received."}';
    final data = jsonDecode(responseText);
    final bool resultIsPhishing = data['isPhishing'] ?? false;
    final String resultExplanation =
        data['explanation'] ?? "No explanation provided.";

    setState(() {
      isPhishing = resultIsPhishing;
      explanation = resultExplanation;
    });

    if (resultIsPhishing) {
      AppToForeground.appToForeground();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndHandleAccessibilityPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    print("disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Phish Detect"),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () async {
              dispose();
              widget.onPermissionNotEnabled!();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentUrl == null
            ? const Center(child: Text("No URL detected yet"))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current URL: $currentUrl",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (isPhishing != null)
              Text(
                "Phishing Status: ${isPhishing! ? "Phishing Detected" : "Not Phishing"}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isPhishing! ? Colors.red : Colors.green,
                ),
              ),
            const SizedBox(height: 16),
            if (explanation != null)
              Text(
                "Explanation: $explanation",
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
