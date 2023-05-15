import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_flutter_animation/src/pages/sketch_book_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        title: 'Bloc & Animation Example',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primarySwatch: Colors.deepOrange,
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(),
          ),
        ),
        home: const CustomPainterPage(),
      ),
      onTap: () {
        // Initilize FocusScope
        FocusScopeNode currentFocus = FocusScope.of(context);
        // Check if Keyboard is in Focus
        if (!currentFocus.hasPrimaryFocus) {
          // Remove/Hide Keyboard from Foucs
          currentFocus.requestFocus(FocusNode());
        }
      },
    );
  }
}
