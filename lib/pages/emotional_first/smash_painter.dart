import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../main.dart';

class SmashPainter extends CustomPainter {
  final double progress;
  final List<Offset> cracks;
  final double waterLevel;

  SmashPainter({
    required this.progress,
    required this.cracks,
    required this.waterLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final totalHeight = size.height;
    
    
    final neckWidth = 40.0;
    final neckHeight = 30.0;
    final neckTopY = totalHeight * 0.05;
    final neckBottomY = neckTopY + neckHeight;
    final bodyTopY = neckBottomY;
    final bodyBottomY = totalHeight * 0.95;
    final bodyRadius = size.width / 2 * 0.7;

    
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

    canvas.drawPath(bottlePath, bodyFillPaint);

    
    final bodyBorderPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawPath(bottlePath, bodyBorderPaint);

    
    if (waterLevel > 0) {
      final waterPaint = Paint()
        ..color = _getWaterColor(waterLevel)
        ..style = PaintingStyle.fill;

      final maxWaterHeight = bodyBottomY - bodyTopY;
      final waterHeight = maxWaterHeight * waterLevel;
      final waterSurfaceY = bodyBottomY - waterHeight;

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
        waterPath.moveTo(centerX - bodyRadius, waterSurfaceY);
        waterPath.lineTo(centerX + bodyRadius, waterSurfaceY);
        waterPath.lineTo(centerX + bodyRadius, bodyBottomY);
        waterPath.lineTo(centerX - bodyRadius, bodyBottomY);
        waterPath.close();
      }

      canvas.save();
      canvas.clipPath(bottlePath);
      canvas.drawPath(waterPath, waterPaint);
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

    
    if (cracks.isNotEmpty) {
      final crackPaint = Paint()
        ..color = Colors.black.withOpacity(0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.save();
      canvas.clipPath(bottlePath); 
      
      for (var crack in cracks) {
        
        final center = crack;
        for (int i = 0; i < 5; i++) {
          final angle = (math.pi * 2 / 5) * i + math.Random().nextDouble() * 0.5;
          final length = 30 + math.Random().nextDouble() * 40;
          final endX = center.dx + math.cos(angle) * length;
          final endY = center.dy + math.sin(angle) * length;
          
          canvas.drawLine(center, Offset(endX, endY), crackPaint);
          
          
          final midX = center.dx + math.cos(angle) * length * 0.6;
          final midY = center.dy + math.sin(angle) * length * 0.6;
          final branchAngle = angle + (math.Random().nextBool() ? 0.5 : -0.5);
          final branchLength = length * 0.3;
          final branchEndX = midX + math.cos(branchAngle) * branchLength;
          final branchEndY = midY + math.sin(branchAngle) * branchLength;
          
          canvas.drawLine(Offset(midX, midY), Offset(branchEndX, branchEndY), crackPaint);
        }
      }
      
      canvas.restore();
    }

    
    if (progress > 0.8) {
      final fragmentPaint = Paint()
        ..color = primaryColor.withOpacity((progress - 0.8) * 5 * 0.6)
        ..style = PaintingStyle.fill;
      
      
      for (int i = 0; i < 12; i++) {
        final random = math.Random(i);
        
        final x = centerX + (random.nextDouble() - 0.5) * bodyRadius * 1.5;
        final y = bodyTopY + random.nextDouble() * (bodyBottomY - bodyTopY);
        final offset = (progress - 0.8) * 5 * 60;
        
        canvas.save();
        canvas.translate(
          x + (random.nextDouble() - 0.5) * offset,
          y + (random.nextDouble() - 0.5) * offset,
        );
        canvas.rotate(random.nextDouble() * math.pi * 2);
        
        
        final path = Path()
          ..moveTo(0, 0)
          ..lineTo(12 + random.nextDouble() * 8, 4 + random.nextDouble() * 4)
          ..lineTo(8 + random.nextDouble() * 6, 12 + random.nextDouble() * 8)
          ..lineTo(-2, 8)
          ..close();
        
        canvas.drawPath(path, fragmentPaint);
        
        
        final fragmentBorderPaint = Paint()
          ..color = primaryColor.withOpacity((progress - 0.8) * 5 * 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawPath(path, fragmentBorderPaint);
        
        canvas.restore();
      }
    }
  }

  Color _getWaterColor(double level) {
    
    return primaryColor.withAlpha(200);
  }

  @override
  bool shouldRepaint(SmashPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.cracks.length != cracks.length;
  }
}

