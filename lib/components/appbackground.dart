import 'package:flutter/material.dart';


class AppBackground extends StatelessWidget {
  const AppBackground(
      {Key? key, this.resizeToAvoidBottomInset, required this.child})
      : super(key: key);

  final Widget child;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: CurvePainter(
          firstColor: Colors.lightGreen.shade200,
          secondColor: Colors.lightGreen.shade100,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final Color firstColor;
  final Color secondColor;

  CurvePainter({required this.firstColor, required this.secondColor});

  @override
  void paint(Canvas canvas, Size size) {
    //draw first cirlce
    final paint = Paint();
    paint.color = firstColor;
    paint.style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height / 2.5);
    path.quadraticBezierTo(
        size.width / 1, size.height / 3, size.width, size.height / 9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    //draw second circle
    final secondPaint = Paint();
    secondPaint.color = secondColor;
    secondPaint.style = PaintingStyle.fill;

    final secondPath = Path();

    secondPath.moveTo(0, size.height / 4);
    secondPath.quadraticBezierTo(
        size.width / 1, size.height / 3, size.width, size.height / 30);
    secondPath.lineTo(size.width, 0);
    secondPath.lineTo(0, 0);

    canvas.drawPath(secondPath, secondPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}