import 'package:flutter/material.dart';
import 'presentation/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
        
      runApp(
        const OKToast( // Wrap your app with OKToast
        child: MyApp(),
        ),
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Add title and theme if desired
      builder: FToastBuilder(),

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

class MyApps extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApps({super.key}); // Instantiate the generated router

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
