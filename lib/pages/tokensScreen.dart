import 'package:flutter/material.dart';

class TokensScreen extends StatefulWidget {
  const TokensScreen({super.key});

  @override
  State<TokensScreen> createState() => _TokensScreenState();
}

class _TokensScreenState extends State<TokensScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("💸 Subscription page"));
  }
}
