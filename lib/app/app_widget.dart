import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_precos/app/controllers/product_controller.dart';
import 'package:app_precos/app/repositories/product_repositorie.dart';
import 'package:app_precos/app/services/product_service.dart';
import 'package:app_precos/app/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductController(ProductRepository(ProductService())),
        ),
      ],
      child: MaterialApp(
        title: 'App Preços',
        debugShowCheckedModeBanner: false,
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
        home: const HomePage(),
      ),
    );
  }
}
