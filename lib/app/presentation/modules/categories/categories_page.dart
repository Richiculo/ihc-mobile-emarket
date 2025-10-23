import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../global/widgets/category_product_card.dart';
import '../../../data/services/local/product_service.dart';
import '../../../domain/models/product.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ProductService _productService = ProductService();
  String _selectedCategory = 'Todas las categorías';

  final Map<String, Map<String, dynamic>> _categoriesData = {
    'Todas las categorías': {
      'icon': Icons.apps,
      'color': AppColors.primary,
      'count': 1250,
    },
    'Frutas y Verduras': {
      'icon': Icons.eco,
      'color': AppColors.textSecondary,
      'count': 180,
    },
    'Carnes y Pescados': {
      'icon': Icons.set_meal,
      'color': AppColors.textSecondary,
      'count': 95,
    },
    'Lácteos y Huevos': {
      'icon': Icons.emoji_food_beverage,
      'color': AppColors.textSecondary,
      'count': 120,
    },
    'Panadería': {
      'icon': Icons.bakery_dining,
      'color': AppColors.textSecondary,
      'count': 50,
    },
    'Bebidas': {
      'icon': Icons.local_drink,
      'color': AppColors.textSecondary,
      'count': 200,
    },
    'Snacks y Dulces': {
      'icon': Icons.cookie,
      'color': AppColors.textSecondary,
      'count': 150,
    },
    'Productos de Limpieza': {
      'icon': Icons.cleaning_services,
      'color': AppColors.textSecondary,
      'count': 80,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategoriesHeader(),

          // Lista de categorías o productos
          Expanded(
            child:
                _selectedCategory == 'Todas las categorías'
                    ? _buildCategoriesList()
                    : _buildProductsList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Categorías',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      centerTitle: false,
    );
  }

  Widget _buildCategoriesHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categorías',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (_selectedCategory != 'Todas las categorías')
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Todas las categorías';
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          _buildAllCategoriesButton(),
        ],
      ),
    );
  }

  Widget _buildAllCategoriesButton() {
    final isSelected = _selectedCategory == 'Todas las categorías';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = 'Todas las categorías';
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.apps, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Todas las categorías',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '1250',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    final categories =
        _categoriesData.entries
            .where((entry) => entry.key != 'Todas las categorías')
            .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final categoryName = category.key;
        final categoryData = category.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCategoryCard(
            categoryName,
            categoryData['icon'],
            categoryData['color'],
            categoryData['count'],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(
    String name,
    IconData icon,
    Color color,
    int count,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ícono de categoría
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.textSecondary, size: 24),
            ),

            const SizedBox(width: 16),

            // Nombre de categoría
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            // Contador de productos
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Flecha
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ...existing code...

  Widget _buildProductsList() {
    List<Product> products;

    if (_selectedCategory == 'Todas las categorías') {
      products = _productService.products;
    } else {
      products = _productService.getProductsByCategory(_selectedCategory);
    }

    if (products.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  _selectedCategory,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${products.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Lista de productos
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CategoryProductCard(
                product: products[index],
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ver detalles de ${products[index].title}'),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                onAddToCart: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${products[index].title} agregado al carrito',
                      ),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.search_off,
                size: 40,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay productos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Esta categoría está vacía por el momento',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
