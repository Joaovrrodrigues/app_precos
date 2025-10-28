import 'package:app_precos/app/controllers/user_list_controller.dart'
    show ListController;
import 'package:app_precos/app/pages/items_list_page.dart';
import 'package:app_precos/app/repositories/user_list_repositorie.dart';
import 'package:app_precos/app/services/user_list_service.dart';
import 'package:app_precos/app/src/models/shopping_item_model.dart';
import 'package:app_precos/app/src/models/shopping_list_model.dart'
    show ShoppingList;
import 'package:flutter/material.dart';
import 'package:app_precos/app/widgets/create_list_dialog.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, Consumer, ReadContext;

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ListController(UserListRepository(UserListService()))..fetchLists(),
      child: const _ListPageContent(),
    );
  }
}

class _ListPageContent extends StatefulWidget {
  const _ListPageContent();

  @override
  State<_ListPageContent> createState() => _ListPageContentState();
}

class _ListPageContentState extends State<_ListPageContent> {
  final TextEditingController _searchController = TextEditingController();
  List<ShoppingList> filteredLists = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterLists);
  }

  void _filterLists() {
    final controller = context.read<ListController>();
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredLists = (controller.lists)
          .where((list) => list.name.toLowerCase().contains(query))
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
    return Consumer<ListController>(
      builder: (context, controller, _) {
        final isLoading = controller.isLoading;
        final hasError = controller.errorMessage != null;

        if (!isLoading &&
            filteredLists.isEmpty &&
            controller.lists.isNotEmpty) {
          filteredLists = List.from(controller.lists);
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Minhas Listas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline),
              ),
            ],
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : hasError
              ? Center(
                  child: Text(
                    'Erro ao carregar listas: ${controller.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Buscar lista...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
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
                          final list = filteredLists[index];
                          return Card(
                            color: const Color(0xFF2A2A2E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(width: 1),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ItemsListPage(shoppingList: list),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            list.description ?? "",
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'R\$ ${list.totalPrice.toString()}',
                                            style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Confirmação'),
                                            content: Text(
                                              'Deseja realmente excluir a lista "${list.name}"?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  context,
                                                ).pop(false),
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  context,
                                                ).pop(true),
                                                child: const Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          final controller = context
                                              .read<ListController>();
                                          await controller.deleteList(
                                            3,
                                            list.id,
                                          );
                                          setState(() {
                                            filteredLists = List.from(
                                              controller.lists,
                                            );
                                          });
                                        }
                                      },
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
                final controller = context.read<ListController>();

                final newList = ShoppingList(
                  id: '',
                  name: result['nome'] ?? 'Nova Lista',
                  description: result['descricao'] ?? '',
                  totalPrice: 0.0,
                  discountTotalPrice: 0.0,
                  items: [
                    ShoppingItem(
                      name: '',
                      brand: '',
                      price: 10.00,
                      discountValue: 0.00,
                      isPurchased: true,
                      id: 'adc482e4-4b41-4f08-aef5-d97af8d56886',
                      quantity: 6,
                      unit: 'un',
                    ),
                  ],
                );

                await controller.addNewList(3, newList);

                setState(() {
                  filteredLists = List.from(controller.lists);
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
      },
    );
  }
}
