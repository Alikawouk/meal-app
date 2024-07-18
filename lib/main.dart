import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meal/screens/tabs_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 132, 0, 51)),
        useMaterial3: true,
      ),
      home: const TabsScreen(),
    );
  }
}
