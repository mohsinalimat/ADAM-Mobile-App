import 'package:flutter/material.dart';

class DrawerIconPainter extends CustomPainter {
  final Color color;

  DrawerIconPainter({this.color});
  static Size size(num width) => Size(
        width,
        (width * 0.8571428571428571).toDouble(),
      );

  Size getSize(num width) => DrawerIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1250000, size.height * 0.6666667);
    path_0.lineTo(size.width * 0.6250000, size.height * 0.6666667);

    Paint paint0stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08333333;
    paint0stroke.color =
        this.color != null ? this.color : Color(0xff0D1333).withOpacity(1.0);
    paint0stroke.strokeCap = StrokeCap.round;
    paint0stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint0stroke);

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color =
        this.color != null ? this.color : Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1250000, size.height * 0.3333333);
    path_1.lineTo(size.width * 0.8750000, size.height * 0.3333333);

    Paint paint1stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08333333;
    paint1stroke.color =
        this.color != null ? this.color : Color(0xff0D1333).withOpacity(1.0);
    paint1stroke.strokeCap = StrokeCap.round;
    paint1stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint1stroke);

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color =
        this.color != null ? this.color : Color(0xff114b8c).withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
