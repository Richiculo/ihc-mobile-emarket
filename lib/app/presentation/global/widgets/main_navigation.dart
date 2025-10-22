import 'package:emarket/app/presentation/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:emarket/app/presentation/modules/home/home_page.dart';
import 'package:emarket/app/presentation/modules/categories/categories_page.dart';
import 'package:emarket/app/presentation/modules/cart/cart_page.dart';
import 'package:emarket/app/presentation/modules/orders/orders_page.dart';
import 'package:emarket/app/presentation/modules/profile/profile_page.dart';
import '../../../data/services/local/cart_service.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ListenableBuilder(
        listenable: CartService(),
        builder: (context, child) {
          final cart = CartService();

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.iconInactive,
            backgroundColor: AppColors.surface,
            onTap: (index) => setState(() => _selectedIndex = index),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categorías',
              ),
              // Carrito con badge
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            cart.itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Carrito',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Mis pedidos',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Yo',
              ),
            ],
          );
        },
      ),
    );
  }
}
