import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PremiumIconPainter extends CustomPainter {
  static Size size(num width) => Size(
        width,
        (width * 0.8571428571428571).toDouble(),
      );

  Size getSize(num width) => PremiumIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6757813, 0);
    path_0.lineTo(size.width * 0.1191406, 0);
    path_0.lineTo(size.width * 0.1777344, size.height * 0.2929688);
    path_0.lineTo(size.width * 0.1777344, size.height * 0.9121094);
    path_0.cubicTo(
        size.width * 0.1777344,
        size.height * 0.9607402,
        size.width * 0.2169883,
        size.height,
        size.width * 0.2656250,
        size.height);
    path_0.lineTo(size.width * 0.4121094, size.height * 0.9994141);
    path_0.lineTo(size.width * 0.8222656, size.height * 0.8828125);
    path_0.lineTo(size.width * 0.8222656, size.height * 0.1464844);
    path_0.cubicTo(size.width * 0.8222656, size.height * 0.06562500,
        size.width * 0.7566406, 0, size.width * 0.6757813, 0);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4707031, size.height),
        Offset(size.width * 0.4707031, 0),
        [Color(0xff5558ff).withOpacity(1), Color(0xff00c0ff).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9101563, size.height * 0.8828125);
    path_1.lineTo(size.width * 0.3828125, size.height * 0.8828125);
    path_1.cubicTo(
        size.width * 0.3664043,
        size.height * 0.8828125,
        size.width * 0.3535156,
        size.height * 0.8957012,
        size.width * 0.3535156,
        size.height * 0.9121094);
    path_1.cubicTo(
        size.width * 0.3535156,
        size.height * 0.9572246,
        size.width * 0.3201172,
        size.height * 0.9941387,
        size.width * 0.2761719,
        size.height * 0.9988262);
    path_1.cubicTo(
        size.width * 0.2732422,
        size.height * 0.9994121,
        size.width * 0.2697266,
        size.height,
        size.width * 0.2656250,
        size.height);
    path_1.lineTo(size.width * 0.8808594, size.height);
    path_1.cubicTo(
        size.width * 0.9130859,
        size.height,
        size.width * 0.9394531,
        size.height * 0.9736328,
        size.width * 0.9394531,
        size.height * 0.9414063);
    path_1.lineTo(size.width * 0.9394531, size.height * 0.9121094);
    path_1.cubicTo(
        size.width * 0.9394531,
        size.height * 0.8957012,
        size.width * 0.9265645,
        size.height * 0.8828125,
        size.width * 0.9101563,
        size.height * 0.8828125);
    path_1.close();
    path_1.moveTo(size.width * 0.1191406, 0);
    path_1.cubicTo(
        size.width * 0.08759766,
        0,
        size.width * 0.06054688,
        size.height * 0.02587305,
        size.width * 0.06054688,
        size.height * 0.05859375);
    path_1.lineTo(size.width * 0.06054688, size.height * 0.2636719);
    path_1.cubicTo(
        size.width * 0.06054688,
        size.height * 0.2800762,
        size.width * 0.07343555,
        size.height * 0.2929688,
        size.width * 0.08984375,
        size.height * 0.2929688);
    path_1.lineTo(size.width * 0.1777344, size.height * 0.2929688);
    path_1.lineTo(size.width * 0.1777344, size.height * 0.05859375);
    path_1.cubicTo(size.width * 0.1777344, size.height * 0.02636719,
        size.width * 0.1513672, 0, size.width * 0.1191406, 0);
    path_1.close();
    path_1.moveTo(size.width * 0.4127969, size.height * 0.3525430);
    path_1.lineTo(size.width * 0.4022402, size.height * 0.4140840);
    path_1.cubicTo(
        size.width * 0.3981426,
        size.height * 0.4379238,
        size.width * 0.4232832,
        size.height * 0.4563145,
        size.width * 0.4447559,
        size.height * 0.4449551);
    path_1.lineTo(size.width * 0.5000000, size.height * 0.4159141);
    path_1.lineTo(size.width * 0.5552461, size.height * 0.4449531);
    path_1.cubicTo(
        size.width * 0.5765645,
        size.height * 0.4561816,
        size.width * 0.6018906,
        size.height * 0.4381074,
        size.width * 0.5977617,
        size.height * 0.4140820);
    path_1.lineTo(size.width * 0.5872051, size.height * 0.3525410);
    path_1.lineTo(size.width * 0.6319238, size.height * 0.3089668);
    path_1.cubicTo(
        size.width * 0.6492891,
        size.height * 0.2920371,
        size.width * 0.6396367,
        size.height * 0.2624902,
        size.width * 0.6156738,
        size.height * 0.2590137);
    path_1.lineTo(size.width * 0.5539043, size.height * 0.2500293);
    path_1.lineTo(size.width * 0.5262676, size.height * 0.1940684);
    path_1.cubicTo(
        size.width * 0.5164258,
        size.height * 0.1740410,
        size.width * 0.4835820,
        size.height * 0.1740410,
        size.width * 0.4737383,
        size.height * 0.1940684);
    path_1.lineTo(size.width * 0.4461016, size.height * 0.2500293);
    path_1.lineTo(size.width * 0.3843320, size.height * 0.2590137);
    path_1.cubicTo(
        size.width * 0.3603301,
        size.height * 0.2624961,
        size.width * 0.3507422,
        size.height * 0.2920625,
        size.width * 0.3680820,
        size.height * 0.3089668);
    path_1.close();
    path_1.moveTo(size.width * 0.3242188, size.height * 0.7050781);
    path_1.lineTo(size.width * 0.6757813, size.height * 0.7050781);
    path_1.cubicTo(
        size.width * 0.6919746,
        size.height * 0.7050781,
        size.width * 0.7050781,
        size.height * 0.6919746,
        size.width * 0.7050781,
        size.height * 0.6757813);
    path_1.cubicTo(
        size.width * 0.7050781,
        size.height * 0.6595879,
        size.width * 0.6919746,
        size.height * 0.6464844,
        size.width * 0.6757813,
        size.height * 0.6464844);
    path_1.lineTo(size.width * 0.3242188, size.height * 0.6464844);
    path_1.cubicTo(
        size.width * 0.3080254,
        size.height * 0.6464844,
        size.width * 0.2949219,
        size.height * 0.6595879,
        size.width * 0.2949219,
        size.height * 0.6757813);
    path_1.cubicTo(
        size.width * 0.2949219,
        size.height * 0.6919746,
        size.width * 0.3080254,
        size.height * 0.7050781,
        size.width * 0.3242188,
        size.height * 0.7050781);
    path_1.close();
    path_1.moveTo(size.width * 0.3242188, size.height * 0.5878906);
    path_1.lineTo(size.width * 0.6757813, size.height * 0.5878906);
    path_1.cubicTo(
        size.width * 0.6919746,
        size.height * 0.5878906,
        size.width * 0.7050781,
        size.height * 0.5747871,
        size.width * 0.7050781,
        size.height * 0.5585938);
    path_1.cubicTo(
        size.width * 0.7050781,
        size.height * 0.5424004,
        size.width * 0.6919746,
        size.height * 0.5292969,
        size.width * 0.6757813,
        size.height * 0.5292969);
    path_1.lineTo(size.width * 0.3242188, size.height * 0.5292969);
    path_1.cubicTo(
        size.width * 0.3080254,
        size.height * 0.5292969,
        size.width * 0.2949219,
        size.height * 0.5424004,
        size.width * 0.2949219,
        size.height * 0.5585938);
    path_1.cubicTo(
        size.width * 0.2949219,
        size.height * 0.5747871,
        size.width * 0.3080254,
        size.height * 0.5878906,
        size.width * 0.3242188,
        size.height * 0.5878906);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, size.height),
        Offset(size.width * 0.5000000, 0), [
      Color(0xffaddcff).withOpacity(1),
      Color(0xffeaf6ff).withOpacity(1),
      Color(0xffeaf6ff).withOpacity(1)
    ], [
      0,
      0.5028,
      1
    ]);
    canvas.drawPath(path_1, paint1fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
