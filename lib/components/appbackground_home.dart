import 'package:flutter/material.dart';

class AppBackgroundHome extends StatelessWidget {
  const AppBackgroundHome(
      {Key? key, this.resizeToAvoidBottomInset, required this.child})
      : super(key: key);

  final Widget child;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3366FF),
            const Color(0xFF00CCFF),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: child,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}

/*class CurvePainter extends CustomPainter {
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

    path.moveTo(0, size.height / 3.9);
    path.quadraticBezierTo(
        size.width * 2, size.height * 1, size.width, size.height * 3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    //draw second circle
    final secondPaint = Paint();
    secondPaint.color = secondColor;
    secondPaint.style = PaintingStyle.fill;

    final secondPath = Path();

    secondPath.moveTo(0, size.height / 4.4);
    secondPath.quadraticBezierTo(
        size.width / 0.8, size.height / 3, size.width, size.height / 7);
    secondPath.lineTo(size.width, 0);
    secondPath.lineTo(0, 0);

    canvas.drawPath(secondPath, secondPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  } */
