import 'package:emoji_scaling/screens/home_screen.dart';
import 'package:flutter/material.dart';

class EmojiScaling extends StatelessWidget {
  const EmojiScaling({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
