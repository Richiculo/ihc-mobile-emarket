import 'package:emarket/app/presentation/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:emarket/app/presentation/modules/home/home_page.dart';
import 'package:emarket/app/presentation/modules/categories/categories_page.dart';
import 'package:emarket/app/presentation/modules/cart/cart_page.dart';
import 'package:emarket/app/presentation/modules/orders/orders_page.dart';
import 'package:emarket/app/presentation/modules/profile/profile_page.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.iconActive,
        unselectedItemColor: AppColors.iconInactive,
        backgroundColor: AppColors.surface,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Mis pedidos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Yo'),
        ],
      ),
    );
  }
}
