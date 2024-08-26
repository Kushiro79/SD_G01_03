import 'package:flutter/material.dart';
import 'presentation/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options:const  FirebaseOptions(
          apiKey: 'AIzaSyCFhSWMK41QR4Q7ocf-BMuETakSgKJUVws',
          authDomain: 'learnsphere-e6563.firebaseapp.com',
          projectId: 'learnsphere-e6563',
          storageBucket: 'learnsphere-e6563.appspot.com',
          messagingSenderId: '603404130009',
          appId: '1:603404130009:web:5fd562b20af226586010c8'));
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
