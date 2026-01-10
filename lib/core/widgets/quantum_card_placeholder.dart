import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class QuantumCardPlaceholder extends StatelessWidget {
  final String zodiacSign;
  final String zodiacSymbol;
  final String planet;
  final String keyword;
  final String element;
  final double width;
  final double height;

  const QuantumCardPlaceholder({
    Key? key,
    required this.zodiacSign,
    required this.zodiacSymbol,
    required this.planet,
    required this.keyword,
    required this.element,
    this.width = 280,
    this.height = 400,
  }) : super(key: key);

  LinearGradient _getElementGradient() {
    switch (element.toLowerCase()) {
      case 'fire':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF6B35), Color(0xFFE63946), Color(0xFFD62828)],
        );
      case 'earth':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B4513), Color(0xFF6B4423), Color(0xFF4A3728)],
        );
      case 'air':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF87CEEB), Color(0xFF4A90E2), Color(0xFF2E5F8A)],
        );
      case 'water':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4169E1), Color(0xFF2F4F8F), Color(0xFF1E3A5F)],
        );
      case 'spirit':
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9B59B6), Color(0xFF8E44AD), Color(0xFF6C3483)],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9B59B6), Color(0xFF8E44AD), Color(0xFF6C3483)],
        );
    }
  }

  Color _getElementColor() {
    switch (element.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B35);
      case 'earth':
        return const Color(0xFF8B4513);
      case 'air':
        return const Color(0xFF87CEEB);
      case 'water':
        return const Color(0xFF4169E1);
      case 'spirit':
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF9B59B6);
    }
  }

  String _getPlanetSymbol() {
    switch (planet.toLowerCase()) {
      case 'sun':
        return '☉';
      case 'moon':
        return '☽';
      case 'mercury':
        return '☿';
      case 'venus':
        return '♀';
      case 'mars':
        return '♂';
      case 'jupiter':
        return '♃';
      case 'saturn':
        return '♄';
      case 'uranus':
        return '⛢';
      case 'neptune':
        return '♆';
      case 'pluto':
        return '♇';
      default:
        return '☉';
    }
  }

  Widget _getPlanetIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Center(
        child: Text(
          _getPlanetSymbol(),
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: _getElementGradient(),
        boxShadow: [
          BoxShadow(
            color: _getElementColor().withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: CardPatternPainter(element: element),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Element badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                      ),
                      child: Text(
                        element.toUpperCase(),
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Large zodiac symbol
                Text(
                  zodiacSymbol,
                  style: GoogleFonts.lato(
                    fontSize: 120,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 16),
                // Sign name
                Text(
                  zodiacSign.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                // Planet name
                Text(
                  planet,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                // Keyword badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  child: Text(
                    keyword.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Planet icon
                _getPlanetIcon(),
              ],
            ),
          ),
          // Glossy overlay effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardPatternPainter extends CustomPainter {
  final String element;

  CardPatternPainter({required this.element});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    switch (element.toLowerCase()) {
      case 'fire':
        _drawTriangles(canvas, size, paint);
        break;
      case 'earth':
        _drawSquares(canvas, size, paint);
        break;
      case 'air':
        _drawCircles(canvas, size, paint);
        break;
      case 'water':
        _drawWaves(canvas, size, paint);
        break;
      case 'spirit':
        _drawStars(canvas, size, paint);
        break;
      default:
        _drawStars(canvas, size, paint);
        break;
    }
  }

  void _drawTriangles(Canvas canvas, Size size, Paint paint) {
    const spacing = 60.0;
    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        final path = Path();
        path.moveTo(x, y - 15);
        path.lineTo(x - 13, y + 10);
        path.lineTo(x + 13, y + 10);
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawSquares(Canvas canvas, Size size, Paint paint) {
    const spacing = 50.0;
    const squareSize = 20.0;
    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        canvas.drawRect(
          Rect.fromLTWH(x - squareSize / 2, y - squareSize / 2, squareSize, squareSize),
          paint,
        );
      }
    }
  }

  void _drawCircles(Canvas canvas, Size size, Paint paint) {
    const spacing = 55.0;
    const radius = 12.0;
    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  void _drawWaves(Canvas canvas, Size size, Paint paint) {
    const waveHeight = 15.0;
    const waveLength = 40.0;
    const spacing = 50.0;

    for (double y = 0; y < size.height + spacing; y += spacing) {
      final path = Path();
      path.moveTo(0, y);

      for (double x = 0; x <= size.width; x += waveLength) {
        path.quadraticBezierTo(
          x + waveLength / 4, y - waveHeight,
          x + waveLength / 2, y,
        );
        path.quadraticBezierTo(
          x + 3 * waveLength / 4, y + waveHeight,
          x + waveLength, y,
        );
      }

      canvas.drawPath(path, paint);
    }
  }

  void _drawStars(Canvas canvas, Size size, Paint paint) {
    const spacing = 60.0;
    const starSize = 10.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        _drawStar(canvas, Offset(x, y), starSize, paint);
      }
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    const numPoints = 5;
    final outerRadius = size;
    final innerRadius = size * 0.4;

    for (int i = 0; i < numPoints * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * math.pi) / numPoints - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}