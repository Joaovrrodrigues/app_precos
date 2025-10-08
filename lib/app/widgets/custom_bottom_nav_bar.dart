import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Minhas Listas'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded), label: 'scannear'),
        BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Ofertas'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Menu'),        
      ],
    );
  }
}
