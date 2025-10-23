import 'package:app_precos/app/src/models/shopping_item_model.dart';
import 'package:flutter/material.dart';
import 'package:app_precos/app/src/models/shopping_list_model.dart';

class ItemsListPage extends StatefulWidget {
  final ShoppingList shoppingList;

  const ItemsListPage({super.key, required this.shoppingList});

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<ShoppingItem> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.shoppingList.items);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredItems = widget.shoppingList.items
          .where((item) => item.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shoppingList.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar produto...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 33, 33, 34),
                hintStyle: const TextStyle(color: Colors.white54),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum produto encontrado',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: const Color(0xFF2A2A2E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(width: 1),
                        ),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          leading: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Marca: ${item.brand}  •  Qtde: ${item.quantity}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Text(
                            'R\$ ${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
