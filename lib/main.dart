import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0A0E21),
          secondary: Color(0xFF6F7693),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      //const Color kActiveCardColor = Color(0xFF1D1E33);
      // const Color kInactiveCardColor = Color(0xFF111328);
      // const Color kBottomContainerColor = Color(0xFFEB1555);
      home: PriceScreen(),
    );
  }
}
