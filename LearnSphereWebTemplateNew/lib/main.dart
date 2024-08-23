import 'package:flutter/material.dart';

import 'presentation/routes/app_router.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget{
  
  
  State<MyApp> createState() => _MyAppState();

}


class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      routerConfig: _appRouter.config() ,
    );
  }
}