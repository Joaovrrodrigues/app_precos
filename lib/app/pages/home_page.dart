import 'package:app_precos/app/pages/main_page.dart';
import 'package:app_precos/app/pages/list_page.dart';
import 'package:app_precos/app/pages/profile_page.dart';
import 'package:app_precos/app/pages/scan_page.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
  MainPage(),
  ListPage(),
  ScanPage(),
  MainPage(),
  ProfilePage(),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
