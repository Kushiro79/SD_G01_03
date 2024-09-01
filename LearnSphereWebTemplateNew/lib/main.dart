import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'presentation/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCFhSWMK41QR4Q7ocf-BMuETakSgKJUVws',
          appId: '1:603404130009:android:7a23f50163cbe61b6010c8',
          messagingSenderId: '603404130009',
          projectId: 'learnsphere-e6563'
          )
      );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Add title and theme if desired
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Use the AutoRoute configuration for navigation
      routerConfig: _appRouter.config(),

      // Add debugShowCheckedModeBanner false to remove the debug banner if needed
      debugShowCheckedModeBanner: false,
    );
  }
}
