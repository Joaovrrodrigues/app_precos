import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String name;
  final String price;
  final String oldPrice;

  const OfferCard({
    super.key,
    required this.name,
    required this.price,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Chip(
              label: Text('50% off'),
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 12,
              ),
              backgroundColor: Color.fromARGB(255, 139, 231, 142),
            ),
          ),
          const Icon(Icons.shopping_cart, color: Colors.white, size: 40),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            oldPrice,
            style: const TextStyle(
              color: Colors.white54,
              decoration: TextDecoration.lineThrough,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
