import 'package:api_fetch/home_page.dart';
import 'package:api_fetch/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> StateProvider()) 
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
