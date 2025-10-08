import 'package:app_precos/app/pages/login_page';
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // adicione o import aqui

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove faixa debug
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Color.fromARGB(255, 53, 153, 95),
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
