import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// A custom painter that draws an animated hourglass with customizable colors and gradients.
class HourglassPainter extends CustomPainter {
  /// The fill amount of the hourglass (0.0 to 1.0)
  final double fillAmount;
  
  /// The colors for the gradient fill
  final List<Color> colors;
  
  /// The color stops for the gradient
  final List<double> colorStops;

  HourglassPainter(this.fillAmount, this.colors, this.colorStops);

  @override
  void paint(Canvas canvas, Size size) {
    double hourglassCurve = size.height * 0.5;
    double hourglassInset = size.width / 10;
    double hourglassHalfHeight = (size.height / 2) - hourglassInset;

    final outlinePainter = Paint()
      ..color = Colors.orangeAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
      
    final outlinePainter2 = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
      
    final contentPainter = Paint()
      ..color = Colors.brown
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    final outline = Path();

    outline.moveTo(hourglassInset, hourglassInset);
    outline.arcToPoint(Offset(size.width - hourglassInset, hourglassInset));
    outline.arcToPoint(Offset(size.width * 0.6, size.height * 0.45),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    outline.arcToPoint(Offset(size.width * 0.55, size.height * 0.55),
        radius: Radius.circular(20), clockwise: false);
    outline.arcToPoint(Offset(size.width - hourglassInset, size.height - 10),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    outline.arcToPoint(Offset(hourglassInset, size.height - hourglassInset));
    outline.arcToPoint(Offset(size.width * 0.45, size.height * 0.55),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    outline.arcToPoint(Offset(size.width * 0.4, size.height * 0.45),
        radius: Radius.circular(20), clockwise: false);
    outline.arcToPoint(Offset(hourglassInset, hourglassInset),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    outline.close();

    final topContent = Path();
    double topStartHeight = size.height * (0.4 - ((1 - fillAmount) * 0.3));
    double topEndHeight = size.height * 0.48;
    double topContentStartWidthOffset =
        getTopContentWidthOffset(size.width, topStartHeight, hourglassHalfHeight, hourglassInset);
    double topContentEndWidthOffset =
        getTopContentWidthOffset(size.width, topEndHeight, hourglassHalfHeight, hourglassInset);

    topContent.moveTo(topContentStartWidthOffset, topStartHeight);
    topContent.arcToPoint(Offset(hourglassInset + topContentEndWidthOffset, topEndHeight),
        radius: Radius.circular(hourglassCurve), clockwise: false);
    topContent.arcToPoint(Offset((size.width - hourglassInset) - topContentEndWidthOffset, topEndHeight));
    topContent.arcToPoint(Offset(size.width - topContentStartWidthOffset, topStartHeight),
        radius: Radius.circular(hourglassCurve), clockwise: false);
    topContent.close();

    final bottomContent = Path();
    double bottomStartHeight = size.height - 12;
    double bottomEndHeight = size.height * (0.95 - (fillAmount * 0.32));
    double bottomContentStartWidthOffset = getBottomContentWidthOffset(
        size.width, bottomStartHeight, hourglassHalfHeight, hourglassInset);
    double bottomContentEndWidthOffset = getBottomContentWidthOffset(
        size.width, bottomEndHeight, hourglassHalfHeight, hourglassInset);

    bottomContent.moveTo(bottomContentStartWidthOffset, bottomStartHeight);
    bottomContent.arcToPoint(Offset(hourglassInset + bottomContentEndWidthOffset, bottomEndHeight),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    bottomContent.arcToPoint(Offset(size.width / 2, bottomEndHeight - size.height * 0.02),
        radius: Radius.circular(hourglassCurve * 1.5));
    bottomContent.arcToPoint(Offset((size.width - hourglassInset) - bottomContentEndWidthOffset, bottomEndHeight),
        radius: Radius.circular(hourglassCurve * 1.5));
    bottomContent.arcToPoint(Offset(size.width - bottomContentStartWidthOffset, bottomStartHeight),
        radius: Radius.circular(hourglassCurve), clockwise: true);
    bottomContent.close();

    final fallingSand = Path();
    fallingSand.moveTo(size.width * 0.4, (size.height * 0.48));
    fallingSand.arcToPoint(Offset(size.width * 0.495, (size.height * 0.57)));
    fallingSand.lineTo(size.width * 0.48, size.height - hourglassInset);
    fallingSand.lineTo(size.width * 0.52, size.height - hourglassInset);
    fallingSand.arcToPoint(Offset(size.width * 0.505, (size.height * 0.57)));
    fallingSand.arcToPoint(Offset(size.width * 0.6, (size.height * 0.48)));
    fallingSand.close();

    final gradient = ui.Gradient.linear(
        Offset(size.width / 2, bottomStartHeight - 1),
        Offset(size.width / 2, bottomEndHeight),
        colors,
        colorStops,
        TileMode.clamp);
        
    final bottomContentPainter = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawPath(fallingSand, contentPainter);
    canvas.drawPath(topContent, contentPainter);
    canvas.drawPath(bottomContent, bottomContentPainter);
    canvas.drawPath(outline, outlinePainter);
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), outlinePainter2);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), outlinePainter2);
  }

  double getTopContentWidthOffset(double width, double height, double fullHeight, double inset) {
    return (((width / 2) - inset) * sin((height / fullHeight) * (pi / 3.8)));
  }

  double getBottomContentWidthOffset(double width, double height, double fullHeight, double inset) {
    return (((width / 2) - inset) * sin(1 - ((height / fullHeight) * (pi / 8.9))));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// A customizable hourglass widget with animated fill and gradient colors.
class Hourglass extends StatelessWidget {
  /// The fill amount of the hourglass (0.0 to 1.0)
  final double fillAmount;
  
  /// The colors for the gradient fill
  final List<Color> colors;
  
  /// The color stops for the gradient
  final List<double> colorStops;
  
  /// The width of the hourglass
  final double width;
  
  /// The height of the hourglass
  final double height;

  const Hourglass({
    super.key,
    required this.fillAmount,
    this.colors = const [Colors.blue, Colors.green, Colors.red],
    this.colorStops = const [0.2, 0.6, 1.0],
    this.width = 100,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: HourglassPainter(fillAmount, colors, colorStops),
      ),
    );
  }
}
