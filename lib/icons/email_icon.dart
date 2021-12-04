import 'package:flutter/material.dart';

class EmailIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9758340, size.height * 0.7958344);
    path_0.cubicTo(
        size.width * 0.9560528,
        size.height * 0.8195843,
        size.width * 0.9267443,
        size.height * 0.8333226,
        size.width * 0.8958342,
        size.height * 0.8333343);
    path_0.lineTo(size.width * 0.1041678, size.height * 0.8333343);
    path_0.cubicTo(
        size.width * 0.07325767,
        size.height * 0.8333226,
        size.width * 0.04394913,
        size.height * 0.8195843,
        size.width * 0.02416792,
        size.height * 0.7958344);
    path_0.lineTo(size.width * 0.4062512, size.height * 0.4775010);
    path_0.lineTo(size.width * 0.4458351, size.height * 0.5045850);
    path_0.cubicTo(
        size.width * 0.4784424,
        size.height * 0.5270849,
        size.width * 0.5215615,
        size.height * 0.5270849,
        size.width * 0.5541688,
        size.height * 0.5045850);
    path_0.lineTo(size.width * 0.5937527, size.height * 0.4775010);
    path_0.lineTo(size.width * 0.9758340, size.height * 0.7958344);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0xff1E88E5).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9816661, size.height * 0.2120855);
    path_1.lineTo(size.width * 0.5937508, size.height * 0.4775010);
    path_1.lineTo(size.width * 0.5541669, size.height * 0.5045850);
    path_1.cubicTo(
        size.width * 0.5215595,
        size.height * 0.5270849,
        size.width * 0.4784405,
        size.height * 0.5270849,
        size.width * 0.4458331,
        size.height * 0.5045850);
    path_1.lineTo(size.width * 0.4062492, size.height * 0.4775010);
    path_1.lineTo(size.width * 0.01833590, size.height * 0.2116676);
    path_1.cubicTo(
        size.width * 0.03785539,
        size.height * 0.1835211,
        size.width * 0.06991588,
        size.height * 0.1667126,
        size.width * 0.1041697,
        size.height * 0.1666676);
    path_1.lineTo(size.width * 0.8958342, size.height * 0.1666676);
    path_1.cubicTo(
        size.width * 0.9302423,
        size.height * 0.1664860,
        size.width * 0.9624610,
        size.height * 0.1835328,
        size.width * 0.9816661,
        size.height * 0.2120855);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Color(0xff64B5F6).withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4062512, size.height * 0.4775010);
    path_2.lineTo(size.width * 0.02416792, size.height * 0.7958344);
    path_2.cubicTo(
        size.width * 0.008529280,
        size.height * 0.7771430,
        size.width * -0.00002734370,
        size.height * 0.7535395,
        size.width * 0.000001953121,
        size.height * 0.7291685);
    path_2.lineTo(size.width * 0.000001953121, size.height * 0.2708354);
    path_2.cubicTo(
        size.width * -0.0001249998,
        size.height * 0.2496968,
        size.width * 0.006279285,
        size.height * 0.2290328,
        size.width * 0.01833590,
        size.height * 0.2116695);
    path_2.lineTo(size.width * 0.4062512, size.height * 0.4775010);
    path_2.close();

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = Color(0xff2196F3).withOpacity(1.0);
    canvas.drawPath(path_2, paint2fill);

    Path path_3 = Path();
    path_3.moveTo(size.width, size.height * 0.2708354);
    path_3.lineTo(size.width, size.height * 0.7291685);
    path_3.cubicTo(
        size.width * 1.000027,
        size.height * 0.7535395,
        size.width * 0.9914727,
        size.height * 0.7771430,
        size.width * 0.9758340,
        size.height * 0.7958344);
    path_3.lineTo(size.width * 0.5937508, size.height * 0.4775010);
    path_3.lineTo(size.width * 0.9816661, size.height * 0.2120855);
    path_3.cubicTo(
        size.width * 0.9936621,
        size.height * 0.2293238,
        size.width * 1.000062,
        size.height * 0.2498335,
        size.width,
        size.height * 0.2708354);
    path_3.close();

    Paint paint3fill = Paint()..style = PaintingStyle.fill;
    paint3fill.color = Color(0xff2196F3).withOpacity(1.0);
    canvas.drawPath(path_3, paint3fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
