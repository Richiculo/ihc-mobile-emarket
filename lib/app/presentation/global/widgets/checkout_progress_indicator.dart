import 'package:flutter/material.dart';
import '../../../domain/models/checkout.dart';
import '../colors.dart';

class CheckoutProgressIndicator extends StatelessWidget {
  final CheckoutStep currentStep;

  const CheckoutProgressIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Círculo con número del paso actual
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                currentStep.number.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
          // Título y subtítulo
          Text(
            currentStep.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 2),

          Text(
            currentStep.subtitle,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),
          _buildCompactProgress(),
        ],
      ),
    );
  }

  Widget _buildCompactProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          CheckoutStep.values.map((step) {
            final isActive = step.number <= currentStep.number;
            final isCurrent = step.number == currentStep.number;
            final isLast = step == CheckoutStep.values.last;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color:
                        isActive ? AppColors.primary : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                    border:
                        isCurrent
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                  ),
                  child: Center(
                    child:
                        step.number < currentStep.number
                            ? Icon(
                              Icons.check,
                              size: 10,
                              color: AppColors.onPrimary,
                            )
                            : null,
                  ),
                ),

                // Línea conectora más corta
                if (!isLast)
                  Container(
                    width: 30,
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color:
                        step.number < currentStep.number
                            ? AppColors.primary
                            : AppColors.surfaceVariant,
                  ),
              ],
            );
          }).toList(),
    );
  }
}
