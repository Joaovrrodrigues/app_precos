import 'package:app_precos/app/widgets/create_list_dialog.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allLists = [
    'Lista do João',
    'Compras da Semana',
    'Feira de Sábado',
    'Mercado Mensal',
    'Atacadão',
  ];

  List<String> filteredLists = [];

  @override
  void initState() {
    super.initState();
    filteredLists = List.from(allLists);
    _searchController.addListener(_filterLists);
  }

  void _filterLists() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredLists = allLists
          .where((listName) => listName.toLowerCase().contains(query))
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Minhas Listas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar lista...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color.fromARGB(255, 33, 33, 34),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredLists.length,
              itemBuilder: (context, index) {
                final name = filteredLists[index];
                return Card(
                  color: const Color(0xFF2A2A2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(width: 1),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // fazer a lógica
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.shopping_cart, color: Colors.white),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Compras para o mês',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white54,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) => const CreateListDialog(),
          );

          if (result != null) {
            setState(() {
              allLists.add(result['nome']!);
              _filterLists();
            });
          }
        },
        backgroundColor: const Color(0xFF8BE78E),
        foregroundColor: Colors.black,
        elevation: 10,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
