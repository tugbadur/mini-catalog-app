import 'package:flutter/material.dart';
import 'package:mini_catalog_app/cart_page.dart';
import 'package:mini_catalog_app/models/product_model.dart';
import 'package:mini_catalog_app/product_details_page.dart';
import 'package:mini_catalog_app/services/product_service.dart';
import 'package:mini_catalog_app/widgets/product_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductModel>> productsFuture;
  String searchQuery = '';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    productsFuture = ProductService.fetchProducts();
  }

  void retryLoadingProducts() {
    setState(() {
      productsFuture = ProductService.fetchProducts();
    });
  }

  Future<void> showCategoryFilter() async {
    try {
      final products = await productsFuture;
      final categories =
          products.map((product) => product.category).toSet().toList()..sort();

      if (!mounted) return;

      final selection = await showDialog<String>(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420.0,
                maxHeight: 480.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Category',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'Choose a category to filter products',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          _categoryOption(
                            title: 'All Categories',
                            icon: Icons.grid_view_rounded,
                            isSelected: selectedCategory == null,
                            onTap: () => Navigator.pop(dialogContext, ''),
                          ),
                          const SizedBox(height: 10.0),
                          ...categories.map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: _categoryOption(
                                title: category,
                                icon: _categoryIcon(category),
                                isSelected: selectedCategory == category,
                                onTap: () =>
                                    Navigator.pop(dialogContext, category),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      if (selection == null || !mounted) return;

      setState(() {
        selectedCategory = selection.isEmpty ? null : selection;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categories could not be loaded.')),
      );
    }
  }

  IconData _categoryIcon(String category) {
    final normalizedCategory = category.toLowerCase();
    if (normalizedCategory.contains('electronics')) return Icons.devices;
    if (normalizedCategory.contains('jewelery')) return Icons.diamond_outlined;
    if (normalizedCategory.contains('clothing')) return Icons.checkroom;
    return Icons.category_outlined;
  }

  Widget _categoryOption({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? Colors.indigo.withOpacity(0.1) : Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: isSelected ? Colors.indigo : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.indigo
                      : Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.indigo,
                  size: 21.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle
                    : Icons.arrow_forward_ios_rounded,
                color: isSelected ? Colors.indigo : Colors.grey,
                size: isSelected ? 22.0 : 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_basket_outlined,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.0,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/banner.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),

              Text(
                'Find Your Favorite Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
              searchBar(),
              if (selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InputChip(
                      label: Text(selectedCategory!),
                      backgroundColor: Colors.white,
                      onDeleted: () {
                        setState(() {
                          selectedCategory = null;
                        });
                      },
                    ),
                  ),
                ),
              FutureBuilder<List<ProductModel>>(
                future: productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Text('Products could not be loaded.'),
                        TextButton(
                          onPressed: retryLoadingProducts,
                          child: const Text('Try Again'),
                        ),
                      ],
                    );
                  }

                  final products = snapshot.data ?? [];
                  final normalizedQuery = searchQuery.trim().toLowerCase();
                  final filteredProducts = products.where((product) {
                    final matchesSearch =
                        normalizedQuery.isEmpty ||
                        product.title.toLowerCase().contains(normalizedQuery) ||
                        product.category.toLowerCase().contains(
                          normalizedQuery,
                        ) ||
                        product.description.toLowerCase().contains(
                          normalizedQuery,
                        );
                    final matchesCategory =
                        selectedCategory == null ||
                        product.category == selectedCategory;

                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'No products found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.6,
                        ),
                    itemCount: filteredProducts.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product),
                            ),
                          );
                        },
                        child: productCard(product),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Container productCard(ProductModel product) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: ProductNetworkImage(
              imageUrl: product.image,
              width: double.infinity,
              height: 180.0,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  product.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search products',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              selectedCategory == null ? Icons.tune : Icons.filter_alt,
              color: Colors.indigo,
            ),
            onPressed: showCategoryFilter,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        ),
      ),
    );
  }
}
