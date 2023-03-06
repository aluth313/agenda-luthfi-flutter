import 'package:agenda_luthfi/ui/pages/home_page.dart';
import 'package:agenda_luthfi/ui/pages/signin_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (context) => SignInPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
