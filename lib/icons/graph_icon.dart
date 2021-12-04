import 'package:flutter/material.dart';

class GraphIconPainter extends CustomPainter {
  final Color color;

  GraphIconPainter({this.color});
  static Size size(num width) => Size(
        width,
        (width * 0.8571428571428571).toDouble(),
      );

  Size getSize(num width) => GraphIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1564453, size.height * 0.7921875);
    path_0.cubicTo(
        size.width * 0.1632812,
        size.height * 0.7968750,
        size.width * 0.1896484,
        size.height * 0.8099609,
        size.width * 0.2119141,
        size.height * 0.7818359);
    path_0.lineTo(size.width * 0.3626953, size.height * 0.5615234);
    path_0.lineTo(size.width * 0.5222656, size.height * 0.7154297);
    path_0.cubicTo(
        size.width * 0.5306641,
        size.height * 0.7234375,
        size.width * 0.5421875,
        size.height * 0.7277344,
        size.width * 0.5539062,
        size.height * 0.7263672);
    path_0.cubicTo(
        size.width * 0.5654297,
        size.height * 0.7251953,
        size.width * 0.5759766,
        size.height * 0.7191406,
        size.width * 0.5828125,
        size.height * 0.7095703);
    path_0.lineTo(size.width * 0.8474609, size.height * 0.3300781);
    path_0.lineTo(size.width * 0.8570312, size.height * 0.4570313);
    path_0.cubicTo(
        size.width * 0.8593750,
        size.height * 0.4892578,
        size.width * 0.8896484,
        size.height * 0.4945312,
        size.width * 0.8998047,
        size.height * 0.4937500);
    path_0.cubicTo(
        size.width * 0.9216797,
        size.height * 0.4919922,
        size.width * 0.9382812,
        size.height * 0.4730469,
        size.width * 0.9365234,
        size.height * 0.4509766);
    path_0.lineTo(size.width * 0.9197266, size.height * 0.2277344);
    path_0.cubicTo(
        size.width * 0.9181641,
        size.height * 0.2058594,
        size.width * 0.8990234,
        size.height * 0.1892578,
        size.width * 0.8769531,
        size.height * 0.1910156);
    path_0.lineTo(size.width * 0.6537109, size.height * 0.2078125);
    path_0.cubicTo(
        size.width * 0.6318359,
        size.height * 0.2093750,
        size.width * 0.6152344,
        size.height * 0.2285156,
        size.width * 0.6169922,
        size.height * 0.2505859);
    path_0.cubicTo(
        size.width * 0.6185547,
        size.height * 0.2724609,
        size.width * 0.6375000,
        size.height * 0.2888672,
        size.width * 0.6597656,
        size.height * 0.2873047);
    path_0.lineTo(size.width * 0.7867187, size.height * 0.2777344);
    path_0.lineTo(size.width * 0.5441406, size.height * 0.6253906);
    path_0.lineTo(size.width * 0.3841797, size.height * 0.4710938);
    path_0.cubicTo(
        size.width * 0.3757812,
        size.height * 0.4628906,
        size.width * 0.3640625,
        size.height * 0.4587891,
        size.width * 0.3525391,
        size.height * 0.4601563);
    path_0.cubicTo(
        size.width * 0.3408203,
        size.height * 0.4613281,
        size.width * 0.3302734,
        size.height * 0.4675781,
        size.width * 0.3236328,
        size.height * 0.4773438);
    path_0.lineTo(size.width * 0.1460937, size.height * 0.7367188);
    path_0.cubicTo(
        size.width * 0.1335937,
        size.height * 0.7548828,
        size.width * 0.1382812,
        size.height * 0.7796875,
        size.width * 0.1564453,
        size.height * 0.7921875);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color =
        this.color != null ? this.color : Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9386719, size.height * 0.8988281);
    path_1.lineTo(size.width * 0.1011719, size.height * 0.8988281);
    path_1.lineTo(size.width * 0.1011719, size.height * 0.06132812);
    path_1.cubicTo(
        size.width * 0.1011719,
        size.height * 0.03925781,
        size.width * 0.08339844,
        size.height * 0.02148438,
        size.width * 0.06132812,
        size.height * 0.02148438);
    path_1.cubicTo(
        size.width * 0.03925781,
        size.height * 0.02148438,
        size.width * 0.02148438,
        size.height * 0.03925781,
        size.width * 0.02148438,
        size.height * 0.06132812);
    path_1.lineTo(size.width * 0.02148438, size.height * 0.9386719);
    path_1.cubicTo(
        size.width * 0.02148438,
        size.height * 0.9607422,
        size.width * 0.03925781,
        size.height * 0.9785156,
        size.width * 0.06132812,
        size.height * 0.9785156);
    path_1.lineTo(size.width * 0.9386719, size.height * 0.9785156);
    path_1.cubicTo(
        size.width * 0.9607422,
        size.height * 0.9785156,
        size.width * 0.9785156,
        size.height * 0.9607422,
        size.width * 0.9785156,
        size.height * 0.9386719);
    path_1.cubicTo(
        size.width * 0.9785156,
        size.height * 0.9166016,
        size.width * 0.9607422,
        size.height * 0.8988281,
        size.width * 0.9386719,
        size.height * 0.8988281);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color =
        this.color != null ? this.color : Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
