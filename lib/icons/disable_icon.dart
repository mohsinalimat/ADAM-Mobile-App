import 'package:flutter/material.dart';

class DisableIconPainter extends CustomPainter {
  final Color color;

  DisableIconPainter({this.color});
  static Size size(num width) => Size(
        width,
        (width * 0.8571428571428571).toDouble(),
      );

  Size getSize(num width) => DisableIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01666667, size.height * 0.01666667);
    path_0.lineTo(size.width * 0.9833333, size.height * 0.01666667);
    path_0.lineTo(size.width * 0.9833333, size.height * 0.1500000);
    path_0.lineTo(size.width * 0.01666667, size.height * 0.1500000);
    path_0.close();
    path_0.moveTo(size.width * 0.01666667, size.height * 0.01666667);

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0xff9bc9ff).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5000000, size.height * 0.3166667);
    path_1.lineTo(size.width * 0.2113363, size.height * 0.8166667);
    path_1.lineTo(size.width * 0.7886637, size.height * 0.8166667);
    path_1.close();
    path_1.moveTo(size.width * 0.5000000, size.height * 0.3166667);

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Color(0xff9bc9ff).withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.2500000, size.height * 0.9000000);
    path_2.lineTo(size.width * 0.2833333, size.height * 0.9000000);
    path_2.lineTo(size.width * 0.2833333, size.height * 0.9333333);
    path_2.lineTo(size.width * 0.2500000, size.height * 0.9333333);
    path_2.close();
    path_2.moveTo(size.width * 0.2500000, size.height * 0.9000000);

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_2, paint2fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3166667, size.height * 0.9000000);
    path_3.lineTo(size.width * 0.3500000, size.height * 0.9000000);
    path_3.lineTo(size.width * 0.3500000, size.height * 0.9333333);
    path_3.lineTo(size.width * 0.3166667, size.height * 0.9333333);
    path_3.close();
    path_3.moveTo(size.width * 0.3166667, size.height * 0.9000000);

    Paint paint3fill = Paint()..style = PaintingStyle.fill;
    paint3fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_3, paint3fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.3833333, size.height * 0.9000000);
    path_4.lineTo(size.width * 0.4166667, size.height * 0.9000000);
    path_4.lineTo(size.width * 0.4166667, size.height * 0.9333333);
    path_4.lineTo(size.width * 0.3833333, size.height * 0.9333333);
    path_4.close();
    path_4.moveTo(size.width * 0.3833333, size.height * 0.9000000);

    Paint paint4fill = Paint()..style = PaintingStyle.fill;
    paint4fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_4, paint4fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4500000, size.height * 0.9000000);
    path_5.lineTo(size.width * 0.4833333, size.height * 0.9000000);
    path_5.lineTo(size.width * 0.4833333, size.height * 0.9333333);
    path_5.lineTo(size.width * 0.4500000, size.height * 0.9333333);
    path_5.close();
    path_5.moveTo(size.width * 0.4500000, size.height * 0.9000000);

    Paint paint5fill = Paint()..style = PaintingStyle.fill;
    paint5fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_5, paint5fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.5166667, size.height * 0.9000000);
    path_6.lineTo(size.width * 0.5500000, size.height * 0.9000000);
    path_6.lineTo(size.width * 0.5500000, size.height * 0.9333333);
    path_6.lineTo(size.width * 0.5166667, size.height * 0.9333333);
    path_6.close();
    path_6.moveTo(size.width * 0.5166667, size.height * 0.9000000);

    Paint paint6fill = Paint()..style = PaintingStyle.fill;
    paint6fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_6, paint6fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.5833333, size.height * 0.9000000);
    path_7.lineTo(size.width * 0.6166667, size.height * 0.9000000);
    path_7.lineTo(size.width * 0.6166667, size.height * 0.9333333);
    path_7.lineTo(size.width * 0.5833333, size.height * 0.9333333);
    path_7.close();
    path_7.moveTo(size.width * 0.5833333, size.height * 0.9000000);

    Paint paint7fill = Paint()..style = PaintingStyle.fill;
    paint7fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_7, paint7fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.6500000, size.height * 0.9000000);
    path_8.lineTo(size.width * 0.6833333, size.height * 0.9000000);
    path_8.lineTo(size.width * 0.6833333, size.height * 0.9333333);
    path_8.lineTo(size.width * 0.6500000, size.height * 0.9333333);
    path_8.close();
    path_8.moveTo(size.width * 0.6500000, size.height * 0.9000000);

    Paint paint8fill = Paint()..style = PaintingStyle.fill;
    paint8fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_8, paint8fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.7166667, size.height * 0.9000000);
    path_9.lineTo(size.width * 0.7500000, size.height * 0.9000000);
    path_9.lineTo(size.width * 0.7500000, size.height * 0.9333333);
    path_9.lineTo(size.width * 0.7166667, size.height * 0.9333333);
    path_9.close();
    path_9.moveTo(size.width * 0.7166667, size.height * 0.9000000);

    Paint paint9fill = Paint()..style = PaintingStyle.fill;
    paint9fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_9, paint9fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.7833333, size.height * 0.9000000);
    path_10.lineTo(size.width * 0.8166667, size.height * 0.9000000);
    path_10.lineTo(size.width * 0.8166667, size.height * 0.9333333);
    path_10.lineTo(size.width * 0.7833333, size.height * 0.9333333);
    path_10.close();
    path_10.moveTo(size.width * 0.7833333, size.height * 0.9000000);

    Paint paint10fill = Paint()..style = PaintingStyle.fill;
    paint10fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_10, paint10fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.1833333, size.height * 0.9000000);
    path_11.lineTo(size.width * 0.2166667, size.height * 0.9000000);
    path_11.lineTo(size.width * 0.2166667, size.height * 0.9333333);
    path_11.lineTo(size.width * 0.1833333, size.height * 0.9333333);
    path_11.close();
    path_11.moveTo(size.width * 0.1833333, size.height * 0.9000000);

    Paint paint11fill = Paint()..style = PaintingStyle.fill;
    paint11fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_11, paint11fill);

    Path path_12 = Path();
    path_12.moveTo(0, 0);
    path_12.lineTo(0, size.height);
    path_12.lineTo(size.width, size.height);
    path_12.lineTo(size.width, 0);
    path_12.close();
    path_12.moveTo(size.width * 0.9666667, size.height * 0.9666667);
    path_12.lineTo(size.width * 0.03333333, size.height * 0.9666667);
    path_12.lineTo(size.width * 0.03333333, size.height * 0.1666667);
    path_12.lineTo(size.width * 0.9666667, size.height * 0.1666667);
    path_12.close();
    path_12.moveTo(size.width * 0.03333333, size.height * 0.1333333);
    path_12.lineTo(size.width * 0.03333333, size.height * 0.03333333);
    path_12.lineTo(size.width * 0.9666667, size.height * 0.03333333);
    path_12.lineTo(size.width * 0.9666667, size.height * 0.1333333);
    path_12.close();
    path_12.moveTo(size.width * 0.03333333, size.height * 0.1333333);

    Paint paint12fill = Paint()..style = PaintingStyle.fill;
    paint12fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_12, paint12fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.1833333, size.height * 0.06666667);
    path_13.lineTo(size.width * 0.2166667, size.height * 0.06666667);
    path_13.lineTo(size.width * 0.2166667, size.height * 0.1000000);
    path_13.lineTo(size.width * 0.1833333, size.height * 0.1000000);
    path_13.close();
    path_13.moveTo(size.width * 0.1833333, size.height * 0.06666667);

    Paint paint13fill = Paint()..style = PaintingStyle.fill;
    paint13fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_13, paint13fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.1166667, size.height * 0.06666667);
    path_14.lineTo(size.width * 0.1500000, size.height * 0.06666667);
    path_14.lineTo(size.width * 0.1500000, size.height * 0.1000000);
    path_14.lineTo(size.width * 0.1166667, size.height * 0.1000000);
    path_14.close();
    path_14.moveTo(size.width * 0.1166667, size.height * 0.06666667);

    Paint paint14fill = Paint()..style = PaintingStyle.fill;
    paint14fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_14, paint14fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.05000000, size.height * 0.06666667);
    path_15.lineTo(size.width * 0.08333333, size.height * 0.06666667);
    path_15.lineTo(size.width * 0.08333333, size.height * 0.1000000);
    path_15.lineTo(size.width * 0.05000000, size.height * 0.1000000);
    path_15.close();
    path_15.moveTo(size.width * 0.05000000, size.height * 0.06666667);

    Paint paint15fill = Paint()..style = PaintingStyle.fill;
    paint15fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_15, paint15fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.4833333, size.height * 0.4333333);
    path_16.lineTo(size.width * 0.5166667, size.height * 0.4333333);
    path_16.lineTo(size.width * 0.5166667, size.height * 0.7000000);
    path_16.lineTo(size.width * 0.4833333, size.height * 0.7000000);
    path_16.close();
    path_16.moveTo(size.width * 0.4833333, size.height * 0.4333333);

    Paint paint16fill = Paint()..style = PaintingStyle.fill;
    paint16fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_16, paint16fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.4833333, size.height * 0.7333333);
    path_17.lineTo(size.width * 0.5166667, size.height * 0.7333333);
    path_17.lineTo(size.width * 0.5166667, size.height * 0.7666667);
    path_17.lineTo(size.width * 0.4833333, size.height * 0.7666667);
    path_17.close();
    path_17.moveTo(size.width * 0.4833333, size.height * 0.7333333);

    Paint paint17fill = Paint()..style = PaintingStyle.fill;
    paint17fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_17, paint17fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.2500000, size.height * 0.2000000);
    path_18.lineTo(size.width * 0.2833333, size.height * 0.2000000);
    path_18.lineTo(size.width * 0.2833333, size.height * 0.2333333);
    path_18.lineTo(size.width * 0.2500000, size.height * 0.2333333);
    path_18.close();
    path_18.moveTo(size.width * 0.2500000, size.height * 0.2000000);

    Paint paint18fill = Paint()..style = PaintingStyle.fill;
    paint18fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_18, paint18fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.3166667, size.height * 0.2000000);
    path_19.lineTo(size.width * 0.3500000, size.height * 0.2000000);
    path_19.lineTo(size.width * 0.3500000, size.height * 0.2333333);
    path_19.lineTo(size.width * 0.3166667, size.height * 0.2333333);
    path_19.close();
    path_19.moveTo(size.width * 0.3166667, size.height * 0.2000000);

    Paint paint19fil = Paint()..style = PaintingStyle.fill;
    paint19fil.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_19, paint19fil);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.3833333, size.height * 0.2000000);
    path_20.lineTo(size.width * 0.4166667, size.height * 0.2000000);
    path_20.lineTo(size.width * 0.4166667, size.height * 0.2333333);
    path_20.lineTo(size.width * 0.3833333, size.height * 0.2333333);
    path_20.close();
    path_20.moveTo(size.width * 0.3833333, size.height * 0.2000000);

    Paint paint20fill = Paint()..style = PaintingStyle.fill;
    paint20fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_20, paint20fill);

    Path path_21 = Path();
    path_21.moveTo(size.width * 0.4500000, size.height * 0.2000000);
    path_21.lineTo(size.width * 0.4833333, size.height * 0.2000000);
    path_21.lineTo(size.width * 0.4833333, size.height * 0.2333333);
    path_21.lineTo(size.width * 0.4500000, size.height * 0.2333333);
    path_21.close();
    path_21.moveTo(size.width * 0.4500000, size.height * 0.2000000);

    Paint paint21fill = Paint()..style = PaintingStyle.fill;
    paint21fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_21, paint21fill);

    Path path_22 = Path();
    path_22.moveTo(size.width * 0.5166667, size.height * 0.2000000);
    path_22.lineTo(size.width * 0.5500000, size.height * 0.2000000);
    path_22.lineTo(size.width * 0.5500000, size.height * 0.2333333);
    path_22.lineTo(size.width * 0.5166667, size.height * 0.2333333);
    path_22.close();
    path_22.moveTo(size.width * 0.5166667, size.height * 0.2000000);

    Paint paint22fill = Paint()..style = PaintingStyle.fill;
    paint22fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_22, paint22fill);

    Path path_23 = Path();
    path_23.moveTo(size.width * 0.5833333, size.height * 0.2000000);
    path_23.lineTo(size.width * 0.6166667, size.height * 0.2000000);
    path_23.lineTo(size.width * 0.6166667, size.height * 0.2333333);
    path_23.lineTo(size.width * 0.5833333, size.height * 0.2333333);
    path_23.close();
    path_23.moveTo(size.width * 0.5833333, size.height * 0.2000000);

    Paint paint23fill = Paint()..style = PaintingStyle.fill;
    paint23fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_23, paint23fill);

    Path path_24 = Path();
    path_24.moveTo(size.width * 0.6500000, size.height * 0.2000000);
    path_24.lineTo(size.width * 0.6833333, size.height * 0.2000000);
    path_24.lineTo(size.width * 0.6833333, size.height * 0.2333333);
    path_24.lineTo(size.width * 0.6500000, size.height * 0.2333333);
    path_24.close();
    path_24.moveTo(size.width * 0.6500000, size.height * 0.2000000);

    Paint paint24fill = Paint()..style = PaintingStyle.fill;
    paint24fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_24, paint24fill);

    Path path_25 = Path();
    path_25.moveTo(size.width * 0.7166667, size.height * 0.2000000);
    path_25.lineTo(size.width * 0.7500000, size.height * 0.2000000);
    path_25.lineTo(size.width * 0.7500000, size.height * 0.2333333);
    path_25.lineTo(size.width * 0.7166667, size.height * 0.2333333);
    path_25.close();
    path_25.moveTo(size.width * 0.7166667, size.height * 0.2000000);

    Paint paint25fill = Paint()..style = PaintingStyle.fill;
    paint25fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_25, paint25fill);

    Path path_26 = Path();
    path_26.moveTo(size.width * 0.7833333, size.height * 0.2000000);
    path_26.lineTo(size.width * 0.8166667, size.height * 0.2000000);
    path_26.lineTo(size.width * 0.8166667, size.height * 0.2333333);
    path_26.lineTo(size.width * 0.7833333, size.height * 0.2333333);
    path_26.close();
    path_26.moveTo(size.width * 0.7833333, size.height * 0.2000000);

    Paint paint26fill = Paint()..style = PaintingStyle.fill;
    paint26fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_26, paint26fill);

    Path path_27 = Path();
    path_27.moveTo(size.width * 0.1833333, size.height * 0.2000000);
    path_27.lineTo(size.width * 0.2166667, size.height * 0.2000000);
    path_27.lineTo(size.width * 0.2166667, size.height * 0.2333333);
    path_27.lineTo(size.width * 0.1833333, size.height * 0.2333333);
    path_27.close();
    path_27.moveTo(size.width * 0.1833333, size.height * 0.2000000);

    Paint paint27fill = Paint()..style = PaintingStyle.fill;
    paint27fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_27, paint27fill);

    Path path_28 = Path();
    path_28.moveTo(size.width * 0.1000000, size.height * 0.2333333);
    path_28.lineTo(size.width * 0.1500000, size.height * 0.2333333);
    path_28.lineTo(size.width * 0.1500000, size.height * 0.2000000);
    path_28.lineTo(size.width * 0.06666667, size.height * 0.2000000);
    path_28.lineTo(size.width * 0.06666667, size.height * 0.2833333);
    path_28.lineTo(size.width * 0.1000000, size.height * 0.2833333);
    path_28.close();
    path_28.moveTo(size.width * 0.1000000, size.height * 0.2333333);

    Paint paint28fill = Paint()..style = PaintingStyle.fill;
    paint28fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_28, paint28fill);

    Path path_29 = Path();
    path_29.moveTo(size.width * 0.9000000, size.height * 0.2833333);
    path_29.lineTo(size.width * 0.9333333, size.height * 0.2833333);
    path_29.lineTo(size.width * 0.9333333, size.height * 0.2000000);
    path_29.lineTo(size.width * 0.8500000, size.height * 0.2000000);
    path_29.lineTo(size.width * 0.8500000, size.height * 0.2333333);
    path_29.lineTo(size.width * 0.9000000, size.height * 0.2333333);
    path_29.close();
    path_29.moveTo(size.width * 0.9000000, size.height * 0.2833333);

    Paint paint29fill = Paint()..style = PaintingStyle.fill;
    paint29fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_29, paint29fill);

    Path path_30 = Path();
    path_30.moveTo(size.width * 0.1500000, size.height * 0.9000000);
    path_30.lineTo(size.width * 0.1000000, size.height * 0.9000000);
    path_30.lineTo(size.width * 0.1000000, size.height * 0.8500000);
    path_30.lineTo(size.width * 0.06666667, size.height * 0.8500000);
    path_30.lineTo(size.width * 0.06666667, size.height * 0.9333333);
    path_30.lineTo(size.width * 0.1500000, size.height * 0.9333333);
    path_30.close();
    path_30.moveTo(size.width * 0.1500000, size.height * 0.9000000);

    Paint paint30fill = Paint()..style = PaintingStyle.fill;
    paint30fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_30, paint30fill);

    Path path_31 = Path();
    path_31.moveTo(size.width * 0.9333333, size.height * 0.8500000);
    path_31.lineTo(size.width * 0.9000000, size.height * 0.8500000);
    path_31.lineTo(size.width * 0.9000000, size.height * 0.9000000);
    path_31.lineTo(size.width * 0.8500000, size.height * 0.9000000);
    path_31.lineTo(size.width * 0.8500000, size.height * 0.9333333);
    path_31.lineTo(size.width * 0.9333333, size.height * 0.9333333);
    path_31.close();
    path_31.moveTo(size.width * 0.9333333, size.height * 0.8500000);

    Paint paint31fill = Paint()..style = PaintingStyle.fill;
    paint31fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_31, paint31fill);

    Path path_32 = Path();
    path_32.moveTo(size.width * 0.06666667, size.height * 0.3166667);
    path_32.lineTo(size.width * 0.1000000, size.height * 0.3166667);
    path_32.lineTo(size.width * 0.1000000, size.height * 0.3500000);
    path_32.lineTo(size.width * 0.06666667, size.height * 0.3500000);
    path_32.close();
    path_32.moveTo(size.width * 0.06666667, size.height * 0.3166667);

    Paint paint32fill = Paint()..style = PaintingStyle.fill;
    paint32fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_32, paint32fill);

    Path path_33 = Path();
    path_33.moveTo(size.width * 0.06666667, size.height * 0.3833333);
    path_33.lineTo(size.width * 0.1000000, size.height * 0.3833333);
    path_33.lineTo(size.width * 0.1000000, size.height * 0.4166667);
    path_33.lineTo(size.width * 0.06666667, size.height * 0.4166667);
    path_33.close();
    path_33.moveTo(size.width * 0.06666667, size.height * 0.3833333);

    Paint paint33fill = Paint()..style = PaintingStyle.fill;
    paint33fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_33, paint33fill);

    Path path_34 = Path();
    path_34.moveTo(size.width * 0.06666667, size.height * 0.4500000);
    path_34.lineTo(size.width * 0.1000000, size.height * 0.4500000);
    path_34.lineTo(size.width * 0.1000000, size.height * 0.4833333);
    path_34.lineTo(size.width * 0.06666667, size.height * 0.4833333);
    path_34.close();
    path_34.moveTo(size.width * 0.06666667, size.height * 0.4500000);

    Paint paint34fill = Paint()..style = PaintingStyle.fill;
    paint34fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_34, paint34fill);

    Path path_35 = Path();
    path_35.moveTo(size.width * 0.06666667, size.height * 0.5166667);
    path_35.lineTo(size.width * 0.1000000, size.height * 0.5166667);
    path_35.lineTo(size.width * 0.1000000, size.height * 0.5500000);
    path_35.lineTo(size.width * 0.06666667, size.height * 0.5500000);
    path_35.close();
    path_35.moveTo(size.width * 0.06666667, size.height * 0.5166667);

    Paint paint35fill = Paint()..style = PaintingStyle.fill;
    paint35fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_35, paint35fill);

    Path path_36 = Path();
    path_36.moveTo(size.width * 0.06666667, size.height * 0.5833333);
    path_36.lineTo(size.width * 0.1000000, size.height * 0.5833333);
    path_36.lineTo(size.width * 0.1000000, size.height * 0.6166667);
    path_36.lineTo(size.width * 0.06666667, size.height * 0.6166667);
    path_36.close();
    path_36.moveTo(size.width * 0.06666667, size.height * 0.5833333);

    Paint paint36fill = Paint()..style = PaintingStyle.fill;
    paint36fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_36, paint36fill);

    Path path_37 = Path();
    path_37.moveTo(size.width * 0.06666667, size.height * 0.6500000);
    path_37.lineTo(size.width * 0.1000000, size.height * 0.6500000);
    path_37.lineTo(size.width * 0.1000000, size.height * 0.6833333);
    path_37.lineTo(size.width * 0.06666667, size.height * 0.6833333);
    path_37.close();
    path_37.moveTo(size.width * 0.06666667, size.height * 0.6500000);

    Paint paint37fill = Paint()..style = PaintingStyle.fill;
    paint37fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_37, paint37fill);

    Path path_38 = Path();
    path_38.moveTo(size.width * 0.06666667, size.height * 0.7166667);
    path_38.lineTo(size.width * 0.1000000, size.height * 0.7166667);
    path_38.lineTo(size.width * 0.1000000, size.height * 0.7500000);
    path_38.lineTo(size.width * 0.06666667, size.height * 0.7500000);
    path_38.close();
    path_38.moveTo(size.width * 0.06666667, size.height * 0.7166667);

    Paint paint38fill = Paint()..style = PaintingStyle.fill;
    paint38fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_38, paint38fill);

    Path path_39 = Path();
    path_39.moveTo(size.width * 0.06666667, size.height * 0.7833333);
    path_39.lineTo(size.width * 0.1000000, size.height * 0.7833333);
    path_39.lineTo(size.width * 0.1000000, size.height * 0.8166667);
    path_39.lineTo(size.width * 0.06666667, size.height * 0.8166667);
    path_39.close();
    path_39.moveTo(size.width * 0.06666667, size.height * 0.7833333);

    Paint paint39fill = Paint()..style = PaintingStyle.fill;
    paint39fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_39, paint39fill);

    Path path_40 = Path();
    path_40.moveTo(size.width * 0.9000000, size.height * 0.3166667);
    path_40.lineTo(size.width * 0.9333333, size.height * 0.3166667);
    path_40.lineTo(size.width * 0.9333333, size.height * 0.3500000);
    path_40.lineTo(size.width * 0.9000000, size.height * 0.3500000);
    path_40.close();
    path_40.moveTo(size.width * 0.9000000, size.height * 0.3166667);

    Paint paint40fill = Paint()..style = PaintingStyle.fill;
    paint40fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_40, paint40fill);

    Path path_41 = Path();
    path_41.moveTo(size.width * 0.9000000, size.height * 0.3833333);
    path_41.lineTo(size.width * 0.9333333, size.height * 0.3833333);
    path_41.lineTo(size.width * 0.9333333, size.height * 0.4166667);
    path_41.lineTo(size.width * 0.9000000, size.height * 0.4166667);
    path_41.close();
    path_41.moveTo(size.width * 0.9000000, size.height * 0.3833333);

    Paint paint41fill = Paint()..style = PaintingStyle.fill;
    paint41fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_41, paint41fill);

    Path path_42 = Path();
    path_42.moveTo(size.width * 0.9000000, size.height * 0.4500000);
    path_42.lineTo(size.width * 0.9333333, size.height * 0.4500000);
    path_42.lineTo(size.width * 0.9333333, size.height * 0.4833333);
    path_42.lineTo(size.width * 0.9000000, size.height * 0.4833333);
    path_42.close();
    path_42.moveTo(size.width * 0.9000000, size.height * 0.4500000);

    Paint paint42fill = Paint()..style = PaintingStyle.fill;
    paint42fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_42, paint42fill);

    Path path_43 = Path();
    path_43.moveTo(size.width * 0.9000000, size.height * 0.5166667);
    path_43.lineTo(size.width * 0.9333333, size.height * 0.5166667);
    path_43.lineTo(size.width * 0.9333333, size.height * 0.5500000);
    path_43.lineTo(size.width * 0.9000000, size.height * 0.5500000);
    path_43.close();
    path_43.moveTo(size.width * 0.9000000, size.height * 0.5166667);

    Paint paint43fill = Paint()..style = PaintingStyle.fill;
    paint43fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_43, paint43fill);

    Path path_44 = Path();
    path_44.moveTo(size.width * 0.9000000, size.height * 0.5833333);
    path_44.lineTo(size.width * 0.9333333, size.height * 0.5833333);
    path_44.lineTo(size.width * 0.9333333, size.height * 0.6166667);
    path_44.lineTo(size.width * 0.9000000, size.height * 0.6166667);
    path_44.close();
    path_44.moveTo(size.width * 0.9000000, size.height * 0.5833333);

    Paint paint44fill = Paint()..style = PaintingStyle.fill;
    paint44fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_44, paint44fill);

    Path path_45 = Path();
    path_45.moveTo(size.width * 0.9000000, size.height * 0.6500000);
    path_45.lineTo(size.width * 0.9333333, size.height * 0.6500000);
    path_45.lineTo(size.width * 0.9333333, size.height * 0.6833333);
    path_45.lineTo(size.width * 0.9000000, size.height * 0.6833333);
    path_45.close();
    path_45.moveTo(size.width * 0.9000000, size.height * 0.6500000);

    Paint paint45fill = Paint()..style = PaintingStyle.fill;
    paint45fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_45, paint45fill);

    Path path_46 = Path();
    path_46.moveTo(size.width * 0.9000000, size.height * 0.7166667);
    path_46.lineTo(size.width * 0.9333333, size.height * 0.7166667);
    path_46.lineTo(size.width * 0.9333333, size.height * 0.7500000);
    path_46.lineTo(size.width * 0.9000000, size.height * 0.7500000);
    path_46.close();
    path_46.moveTo(size.width * 0.9000000, size.height * 0.7166667);

    Paint paint46fill = Paint()..style = PaintingStyle.fill;
    paint46fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_46, paint46fill);

    Path path_47 = Path();
    path_47.moveTo(size.width * 0.9000000, size.height * 0.7833333);
    path_47.lineTo(size.width * 0.9333333, size.height * 0.7833333);
    path_47.lineTo(size.width * 0.9333333, size.height * 0.8166667);
    path_47.lineTo(size.width * 0.9000000, size.height * 0.8166667);
    path_47.close();
    path_47.moveTo(size.width * 0.9000000, size.height * 0.7833333);

    Paint paint47fill = Paint()..style = PaintingStyle.fill;
    paint47fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_47, paint47fill);

    Path path_48 = Path();
    path_48.moveTo(size.width * 0.2500000, size.height * 0.06666667);
    path_48.lineTo(size.width * 0.9333333, size.height * 0.06666667);
    path_48.lineTo(size.width * 0.9333333, size.height * 0.1000000);
    path_48.lineTo(size.width * 0.2500000, size.height * 0.1000000);
    path_48.close();
    path_48.moveTo(size.width * 0.2500000, size.height * 0.06666667);

    Paint paint48fill = Paint()..style = PaintingStyle.fill;
    paint48fill.color = Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_48, paint48fill);

    Path path_49 = Path();
    path_49.moveTo(size.width * 0.5000000, size.height * 0.2833333);
    path_49.lineTo(size.width * 0.1824463, size.height * 0.8333333);
    path_49.lineTo(size.width * 0.8175537, size.height * 0.8333333);
    path_49.close();
    path_49.moveTo(size.width * 0.5000000, size.height * 0.3500000);
    path_49.lineTo(size.width * 0.7597982, size.height * 0.8000000);
    path_49.lineTo(size.width * 0.2402018, size.height * 0.8000000);
    path_49.close();
    path_49.moveTo(size.width * 0.5000000, size.height * 0.3500000);

    Paint paint49fill = Paint()..style = PaintingStyle.fill;
    paint49fill.color =
        this.color != null ? this.color : Color(0xff1e81ce).withOpacity(1.0);
    canvas.drawPath(path_49, paint49fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
