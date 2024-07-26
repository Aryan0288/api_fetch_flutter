import 'package:add_to_cart2/pages/home_page.dart';
import 'package:add_to_cart2/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProviders()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
