// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final storyController = StoryController();
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }
  List img = [
    'assets/hearts.png',
    'assets/send.png',
  ];
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("sadhjhdk"),
      ),
    );
  }
}
