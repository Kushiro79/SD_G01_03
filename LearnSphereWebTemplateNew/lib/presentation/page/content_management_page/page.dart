import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class ContentManagementPage extends StatelessWidget {
  const ContentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Management'),
      ),
    );
    
    
    
  }
}