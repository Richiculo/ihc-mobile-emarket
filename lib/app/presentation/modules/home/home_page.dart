import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../global/widgets/search_bar_widget.dart';
import '../../global/widgets/repeat_order_section.dart';
import '../../global/widgets/discount_banner.dart';
import '../../global/widgets/product_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'YeskiMarket',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: const [SearchBarWidget(), SizedBox(width: 16)],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            RepeatOrderSection(),
            SizedBox(height: 50),
            DiscountBanner(),
            SizedBox(height: 50),
            ProductGrid(),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
