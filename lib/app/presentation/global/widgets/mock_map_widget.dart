import 'package:flutter/material.dart';
import '../colors.dart';

class MockMapWidget extends StatelessWidget {
  final String address;
  final VoidCallback? onTap;
  final bool isTracking; // ✅ Agregar parámetro isTracking

  const MockMapWidget({
    super.key,
    required this.address,
    this.onTap,
    this.isTracking = false, // ✅ Default false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Imagen de mapa estática
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        isTracking
                            ? [
                              Colors.blue.shade200,
                              Colors.green.shade200,
                            ] // ✅ Colores más vivos para tracking
                            : [Colors.blue.shade100, Colors.green.shade100],
                  ),
                ),
                child: CustomPaint(painter: _MapPainter()),
              ),

              // ✅ Pin principal de ubicación
              Positioned(
                top: 80,
                left: MediaQuery.of(context).size.width * 0.4,
                child: Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),

              // ✅ Pin del repartidor si está en modo tracking
              if (isTracking)
                Positioned(
                  top: 60,
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.inProgress, width: 2),
                    ),
                    child: Icon(
                      Icons.delivery_dining,
                      color: AppColors.inProgress,
                      size: 20,
                    ),
                  ),
                ),

              // ✅ Ruta simulada si está en tracking
              if (isTracking)
                Positioned.fill(child: CustomPaint(painter: _RoutePainter())),

              // Overlay con dirección
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isTracking ? Icons.navigation : Icons.location_on,
                        size: 16,
                        color:
                            isTracking
                                ? AppColors.inProgress
                                : AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isTracking
                              ? 'Repartidor en camino a: $address'
                              : address,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isTracking) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.inProgress.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'En vivo',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.inProgress,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
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

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.3)
          ..strokeWidth = 1;

    // Dibujar líneas simulando calles
    for (int i = 0; i < 10; i++) {
      final y = (size.height / 10) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (int i = 0; i < 8; i++) {
      final x = (size.width / 8) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ✅ Nuevo painter para dibujar la ruta en modo tracking
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFFC107) // Amber
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    // Dibujar una ruta curva simulada
    final path = Path();
    final startX = size.width * 0.3;
    final startY = 70.0;
    final endX = size.width * 0.4;
    final endY = 90.0;

    path.moveTo(startX, startY);
    path.quadraticBezierTo(
      size.width * 0.5, // control point x
      startY + 20, // control point y
      endX, // end x
      endY, // end y
    );

    canvas.drawPath(path, paint);

    // Dibujar puntos en la ruta para animación
    final dotPaint =
        Paint()
          ..color = const Color(0xFFFFC107)
          ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      final t = i / 4.0;
      final x = startX + (endX - startX) * t;
      final y =
          startY + (endY - startY) * t + (20 * (1 - 4 * (t - 0.5) * (t - 0.5)));
      canvas.drawCircle(Offset(x, y), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
