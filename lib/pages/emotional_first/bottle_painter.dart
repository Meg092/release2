import 'package:flutter/material.dart';

import '../../main.dart';

class BottlePainter extends CustomPainter {
  final double waterLevel;
  final double tiltAngle;
  final double neckWidth;
  final double neckHeight;
  final double bottleWidth;
  final double bottleHeight;

  BottlePainter({
    required this.waterLevel,
    required this.tiltAngle,
    this.neckWidth = 40,
    this.neckHeight = 30,
    this.bottleWidth = 150,
    this.bottleHeight = 250,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final totalHeight = size.height;


    final neckTopY = totalHeight * 0.05;
    final neckBottomY = neckTopY + neckHeight;
    final bodyTopY = neckBottomY;
    final bodyBottomY = totalHeight * 0.95;


    final bodyRadius = bottleWidth / 2 * 0.7;

    final bottlePath = Path()

      ..moveTo(centerX - neckWidth / 2, neckTopY)
      ..lineTo(centerX + neckWidth / 2, neckTopY)

      ..lineTo(centerX + neckWidth / 2, neckBottomY)

      ..lineTo(centerX + bodyRadius, bodyTopY)

      ..lineTo(centerX + bodyRadius, bodyBottomY)

      ..lineTo(centerX - bodyRadius, bodyBottomY)

      ..lineTo(centerX - bodyRadius, bodyTopY)

      ..lineTo(centerX - neckWidth / 2, neckBottomY)
      ..close();


    final bodyFillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;


    final bodyBorderPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(bottlePath, bodyFillPaint);


    canvas.drawPath(bottlePath, bodyBorderPaint);


    if (waterLevel > 0) {
      final waterPaint = Paint()
        ..color = _getWaterColor(waterLevel)
        ..style = PaintingStyle.fill;


      final maxWaterHeight = bodyBottomY - bodyTopY;
      final waterHeight = maxWaterHeight * waterLevel;
      final waterSurfaceY = bodyBottomY - waterHeight;


      final maxOffset = bodyRadius * 0.8;
      final waterOffset = tiltAngle * maxOffset;


      final waterPath = Path();


      if (waterSurfaceY < bodyTopY) {

        waterPath.addRect(Rect.fromLTRB(
          centerX - neckWidth / 2,
          waterSurfaceY,
          centerX + neckWidth / 2,
          neckBottomY,
        ));


        waterPath.addRect(Rect.fromLTRB(
          centerX - bodyRadius,
          bodyTopY,
          centerX + bodyRadius,
          bodyBottomY,
        ));
      } else {

        final leftSurfaceX = centerX - bodyRadius + waterOffset;
        final rightSurfaceX = centerX + bodyRadius + waterOffset;


        waterPath.moveTo(leftSurfaceX, waterSurfaceY);
        waterPath.lineTo(rightSurfaceX, waterSurfaceY);
        waterPath.lineTo(centerX + bodyRadius, bodyBottomY);
        waterPath.lineTo(centerX - bodyRadius, bodyBottomY);
        waterPath.close();
      }


      canvas.save();
      canvas.clipPath(bottlePath);
      canvas.drawPath(waterPath, waterPaint);


      if (waterLevel > 0.1) {
        final highlightPaint = Paint()
          ..color = Colors.white.withAlpha(150)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;


        if (waterSurfaceY >= bodyTopY) {

          final leftSurfaceX = centerX - bodyRadius + waterOffset;
          final rightSurfaceX = centerX + bodyRadius + waterOffset;

          canvas.drawLine(
            Offset(leftSurfaceX, waterSurfaceY),
            Offset(rightSurfaceX, waterSurfaceY),
            highlightPaint,
          );
        }
      }

      canvas.restore();
    }

    final neckDetailPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(centerX - neckWidth / 2, neckTopY),
      Offset(centerX + neckWidth / 2, neckTopY),
      neckDetailPaint,
    );

    for (int i = 0; i < 3; i++) {
      final threadY = neckTopY + (i + 1) * neckHeight / 4;
      canvas.drawLine(
        Offset(centerX - neckWidth / 2, threadY),
        Offset(centerX - neckWidth / 2 + 5, threadY),
        neckDetailPaint,
      );
      canvas.drawLine(
        Offset(centerX + neckWidth / 2 - 5, threadY),
        Offset(centerX + neckWidth / 2, threadY),
        neckDetailPaint,
      );
    }
  }

  Color _getWaterColor(double level) {
    if (level > 0.7) return primaryColor.withAlpha(200);
    if (level > 0.3) return primaryColor.withAlpha(100);
    return primaryColor.withAlpha(50);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}