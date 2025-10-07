import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Página Inicial', style: TextStyle(fontSize: 24, color: Colors.white))),
    Center(child: Text('Listas', style: TextStyle(fontSize: 24, color: Colors.white))),
    Center(child: Text('Ofertas', style: TextStyle(fontSize: 24, color: Colors.white))),
    Center(child: Text('Menu', style: TextStyle(fontSize: 24, color: Colors.white))),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Minhas Listas'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Ofertas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Menu'),
        ],
      ),
    );
  }
}
