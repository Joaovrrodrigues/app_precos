import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_precos/app/controllers/product_controller.dart';
import 'package:app_precos/app/widgets/offer_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().findAllProducts();
    });

    _scrollController.addListener(() {
      final controller = context.read<ProductController>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !controller.isLoading) {
        controller.findAllProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Olá, João',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.findAllProducts(),
        color: const Color.fromARGB(255, 139, 231, 142),
        backgroundColor: const Color(0xFF1C1C1C),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1C1C1C), Color(0xFF2A2A2A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_offer,
                      color: Color(0xFF8BE78E),
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pronto para economizar?',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Você pode economizar até R\$ 69,00',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.handshake),
                  label: const Text('Anúncie Aqui'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 139, 231, 142),
                    foregroundColor: const Color(0xFF000000),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Ofertas perto de você',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              if (controller.isLoading && controller.products.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 139, 231, 142),
                    ),
                  ),
                )
              else if (controller.products.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Nenhum produto encontrado 😕',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        controller.products.length +
                        (controller.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.products.length) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 139, 231, 142),
                            ),
                          ),
                        );
                      }

                      final product = controller.products[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: OfferCard(
                          name: product.name,
                          price: 'R\$ ${product.price.toStringAsFixed(2)}',
                          oldPrice: 'R\$ ${product.price.toStringAsFixed(2)}',
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 30),
    
              const Text(
                'Mais ofertas que você pode gostar',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children: List.generate(controller.products.length, (index) {
                  final product = controller.products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      child: OfferCard(
                        name: product.name,
                        price: 'R\$ ${product.price.toStringAsFixed(2)}',
                        oldPrice: 'R\$ ${product.price.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                }),
              ),

              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 139, 231, 142),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
