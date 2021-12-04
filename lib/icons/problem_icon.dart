import 'package:flutter/material.dart';

class ProblemIconPainter extends CustomPainter {
  static Size size(num width) => Size(
        width,
        (width * 0.8).toDouble(),
      );

  Size getSize(num width) => ProblemIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.1093750, size.height * 0.6406250),
        size.width * 0.03125000, paint0fill);

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.2187500, size.height * 0.6406250),
        size.width * 0.03125000, paint1fill);

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.3281250, size.height * 0.6406250),
        size.width * 0.03125000, paint2fill);

    Paint paint3fill = Paint()..style = PaintingStyle.fill;
    paint3fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.1093750, size.height * 0.4218750),
        size.width * 0.03125000, paint3fill);

    Paint paint4fill = Paint()..style = PaintingStyle.fill;
    paint4fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.2187500, size.height * 0.4218750),
        size.width * 0.03125000, paint4fill);

    Paint paint5fill = Paint()..style = PaintingStyle.fill;
    paint5fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.3281250, size.height * 0.4218750),
        size.width * 0.03125000, paint5fill);

    Paint paint6fill = Paint()..style = PaintingStyle.fill;
    paint6fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.1093750, size.height * 0.8593750),
        size.width * 0.03125000, paint6fill);

    Paint paint7fill = Paint()..style = PaintingStyle.fill;
    paint7fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.2187500, size.height * 0.8593750),
        size.width * 0.03125000, paint7fill);

    Paint paint8fill = Paint()..style = PaintingStyle.fill;
    paint8fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.3281250, size.height * 0.8593750),
        size.width * 0.03125000, paint8fill);

    Path path9 = Path();
    path9.moveTo(size.width * 0.3281250, size.height * 0.2656250);
    path9.lineTo(size.width * 0.3906250, size.height * 0.2656250);
    path9.lineTo(size.width * 0.3906250, size.height * 0.3125000);
    path9.lineTo(size.width * 0.3281250, size.height * 0.3125000);
    path9.close();

    Paint paint9fill = Paint()..style = PaintingStyle.fill;
    paint9fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawPath(path9, paint9fill);

    Path path10 = Path();
    path10.moveTo(size.width * 0.9641211, size.height * 0.4009180);
    path10.lineTo(size.width * 0.7763086, size.height * 0.05650391);
    path10.cubicTo(
        size.width * 0.7590234,
        size.height * 0.02195313,
        size.width * 0.7097266,
        size.height * 0.02195313,
        size.width * 0.6924414,
        size.height * 0.05650391);
    path10.lineTo(size.width * 0.5528516, size.height * 0.3125000);
    path10.lineTo(size.width * 0.5046289, size.height * 0.4009180);
    path10.arcToPoint(Offset(size.width * 0.5465430, size.height * 0.4687500),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path10.lineTo(size.width * 0.9222070, size.height * 0.4687500);
    path10.arcToPoint(Offset(size.width * 0.9641211, size.height * 0.4009180),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path10.close();
    path10.moveTo(size.width * 0.7656250, size.height * 0.4218750);
    path10.lineTo(size.width * 0.7031250, size.height * 0.4218750);
    path10.lineTo(size.width * 0.7031250, size.height * 0.3593750);
    path10.lineTo(size.width * 0.7656250, size.height * 0.3593750);
    path10.close();
    path10.moveTo(size.width * 0.7500000, size.height * 0.3125000);
    path10.lineTo(size.width * 0.7187500, size.height * 0.3125000);
    path10.lineTo(size.width * 0.7031250, size.height * 0.1250000);
    path10.lineTo(size.width * 0.7656250, size.height * 0.1250000);
    path10.close();

    Paint paint10fill = Paint()..style = PaintingStyle.fill;
    paint10fill.color = Color(0xff57a4ff).withOpacity(1.0);
    canvas.drawPath(path10, paint10fill);

    Path path11 = Path();
    path11.moveTo(size.width * 0.9781055, size.height * 0.3939258);
    path11.cubicTo(
        size.width * 0.9780273,
        size.height * 0.3937500,
        size.width * 0.9779297,
        size.height * 0.3935938,
        size.width * 0.9778516,
        size.height * 0.3934375);
    path11.lineTo(size.width * 0.7901367, size.height * 0.04925781);
    path11.arcToPoint(Offset(size.width * 0.6786133, size.height * 0.04925781),
        radius: Radius.elliptical(
            size.width * 0.06250000, size.height * 0.06250000),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.5435547, size.height * 0.2968750);
    path11.lineTo(size.width * 0.4062500, size.height * 0.2968750);
    path11.lineTo(size.width * 0.4062500, size.height * 0.2656250);
    path11.arcToPoint(Offset(size.width * 0.3906250, size.height * 0.2500000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.3281250, size.height * 0.2500000);
    path11.arcToPoint(Offset(size.width * 0.3125000, size.height * 0.2656250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.3125000, size.height * 0.2968750);
    path11.lineTo(size.width * 0.07812500, size.height * 0.2968750);
    path11.arcToPoint(Offset(size.width * 0.01562500, size.height * 0.3593750),
        radius: Radius.elliptical(
            size.width * 0.06257031, size.height * 0.06257031),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.01562500, size.height * 0.4843750);
    path11.arcToPoint(Offset(size.width * 0.03685547, size.height * 0.5312500),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.arcToPoint(Offset(size.width * 0.01562500, size.height * 0.5781250),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.01562500, size.height * 0.7031250);
    path11.arcToPoint(Offset(size.width * 0.03685547, size.height * 0.7500000),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.arcToPoint(Offset(size.width * 0.01562500, size.height * 0.7968750),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.01562500, size.height * 0.9218750);
    path11.arcToPoint(Offset(size.width * 0.07812500, size.height * 0.9843750),
        radius: Radius.elliptical(
            size.width * 0.06257031, size.height * 0.06257031),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.6406250, size.height * 0.9843750);
    path11.arcToPoint(Offset(size.width * 0.7031250, size.height * 0.9218750),
        radius: Radius.elliptical(
            size.width * 0.06257031, size.height * 0.06257031),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.7031250, size.height * 0.7968750);
    path11.arcToPoint(Offset(size.width * 0.6818945, size.height * 0.7500000),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.arcToPoint(Offset(size.width * 0.7031250, size.height * 0.7031250),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.7031250, size.height * 0.5781250);
    path11.arcToPoint(Offset(size.width * 0.6818945, size.height * 0.5312500),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.arcToPoint(Offset(size.width * 0.7031250, size.height * 0.4843750),
        radius: Radius.elliptical(
            size.width * 0.06234375, size.height * 0.06234375),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.9222070, size.height * 0.4843750);
    path11.arcToPoint(Offset(size.width * 0.9781055, size.height * 0.3939258),
        radius: Radius.elliptical(
            size.width * 0.06250000, size.height * 0.06250000),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.close();
    path11.moveTo(size.width * 0.3437500, size.height * 0.2812500);
    path11.lineTo(size.width * 0.3750000, size.height * 0.2812500);
    path11.lineTo(size.width * 0.3750000, size.height * 0.2968750);
    path11.lineTo(size.width * 0.3437500, size.height * 0.2968750);
    path11.close();
    path11.moveTo(size.width * 0.6718750, size.height * 0.9218750);
    path11.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.9531250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.07812500, size.height * 0.9531250);
    path11.arcToPoint(Offset(size.width * 0.04687500, size.height * 0.9218750),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.04687500, size.height * 0.7968750);
    path11.arcToPoint(Offset(size.width * 0.07812500, size.height * 0.7656250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.6406250, size.height * 0.7656250);
    path11.arcToPoint(Offset(size.width * 0.6718750, size.height * 0.7968750),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.close();
    path11.moveTo(size.width * 0.6718750, size.height * 0.7031250);
    path11.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.7343750),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.07812500, size.height * 0.7343750);
    path11.arcToPoint(Offset(size.width * 0.04687500, size.height * 0.7031250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.04687500, size.height * 0.5781250);
    path11.arcToPoint(Offset(size.width * 0.07812500, size.height * 0.5468750),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.6406250, size.height * 0.5468750);
    path11.arcToPoint(Offset(size.width * 0.6718750, size.height * 0.5781250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.close();
    path11.moveTo(size.width * 0.6406250, size.height * 0.5156250);
    path11.lineTo(size.width * 0.07812500, size.height * 0.5156250);
    path11.arcToPoint(Offset(size.width * 0.04687500, size.height * 0.4843750),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.04687500, size.height * 0.3593750);
    path11.arcToPoint(Offset(size.width * 0.07812500, size.height * 0.3281250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.5265234, size.height * 0.3281250);
    path11.lineTo(size.width * 0.4908984, size.height * 0.3934375);
    path11.cubicTo(
        size.width * 0.4908203,
        size.height * 0.3935938,
        size.width * 0.4907227,
        size.height * 0.3937500,
        size.width * 0.4906445,
        size.height * 0.3939258);
    path11.arcToPoint(Offset(size.width * 0.5465430, size.height * 0.4843750),
        radius: Radius.elliptical(
            size.width * 0.06250000, size.height * 0.06250000),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path11.lineTo(size.width * 0.6718750, size.height * 0.4843750);
    path11.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.5156250),
        radius: Radius.elliptical(
            size.width * 0.03129102, size.height * 0.03129102),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.close();
    path11.moveTo(size.width * 0.9487891, size.height * 0.4383008);
    path11.arcToPoint(Offset(size.width * 0.9222070, size.height * 0.4531250),
        radius: Radius.elliptical(
            size.width * 0.03108203, size.height * 0.03108203),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.5465430, size.height * 0.4531250);
    path11.arcToPoint(Offset(size.width * 0.5184766, size.height * 0.4081250),
        radius: Radius.elliptical(
            size.width * 0.03125000, size.height * 0.03125000),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.lineTo(size.width * 0.5664453, size.height * 0.3201758);
    path11.cubicTo(
        size.width * 0.5665430,
        size.height * 0.3200195,
        size.width * 0.5666211,
        size.height * 0.3198828,
        size.width * 0.5666992,
        size.height * 0.3197266);
    path11.lineTo(size.width * 0.7061719, size.height * 0.06398438);
    path11.cubicTo(
        size.width * 0.7062500,
        size.height * 0.06382813,
        size.width * 0.7063477,
        size.height * 0.06367188,
        size.width * 0.7064258,
        size.height * 0.06349609);
    path11.arcToPoint(Offset(size.width * 0.7623242, size.height * 0.06349609),
        radius: Radius.elliptical(
            size.width * 0.03125000, size.height * 0.03125000),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.cubicTo(
        size.width * 0.7624023,
        size.height * 0.06367188,
        size.width * 0.7625000,
        size.height * 0.06382813,
        size.width * 0.7625781,
        size.height * 0.06398438);
    path11.lineTo(size.width * 0.9502734, size.height * 0.4081250);
    path11.arcToPoint(Offset(size.width * 0.9487891, size.height * 0.4383008),
        radius: Radius.elliptical(
            size.width * 0.03109570, size.height * 0.03109570),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path11.close();

    Paint paint11fill = Paint()..style = PaintingStyle.fill;
    paint11fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path11, paint11fill);

    Path path12 = Path();
    path12.moveTo(size.width * 0.7771289, size.height * 0.1144141);
    path12.arcToPoint(Offset(size.width * 0.7656250, size.height * 0.1093750),
        radius: Radius.elliptical(
            size.width * 0.01568555, size.height * 0.01568555),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path12.lineTo(size.width * 0.7031250, size.height * 0.1093750);
    path12.arcToPoint(Offset(size.width * 0.6875586, size.height * 0.1262891),
        radius: Radius.elliptical(
            size.width * 0.01559961, size.height * 0.01559961),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path12.lineTo(size.width * 0.7031836, size.height * 0.3137891);
    path12.arcToPoint(Offset(size.width * 0.7187500, size.height * 0.3281250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path12.lineTo(size.width * 0.7500000, size.height * 0.3281250);
    path12.arcToPoint(Offset(size.width * 0.7655664, size.height * 0.3137891),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path12.lineTo(size.width * 0.7811914, size.height * 0.1262891);
    path12.arcToPoint(Offset(size.width * 0.7771289, size.height * 0.1144141),
        radius: Radius.elliptical(
            size.width * 0.01565039, size.height * 0.01565039),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path12.close();
    path12.moveTo(size.width * 0.7356250, size.height * 0.2968750);
    path12.lineTo(size.width * 0.7331250, size.height * 0.2968750);
    path12.lineTo(size.width * 0.7200977, size.height * 0.1406250);
    path12.lineTo(size.width * 0.7486523, size.height * 0.1406250);
    path12.close();

    Paint paint12fill = Paint()..style = PaintingStyle.fill;
    paint12fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path12, paint12fill);

    Path path13 = Path();
    path13.moveTo(size.width * 0.7656250, size.height * 0.3437500);
    path13.lineTo(size.width * 0.7031250, size.height * 0.3437500);
    path13.arcToPoint(Offset(size.width * 0.6875000, size.height * 0.3593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path13.lineTo(size.width * 0.6875000, size.height * 0.4218750);
    path13.arcToPoint(Offset(size.width * 0.7031250, size.height * 0.4375000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path13.lineTo(size.width * 0.7656250, size.height * 0.4375000);
    path13.arcToPoint(Offset(size.width * 0.7812500, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path13.lineTo(size.width * 0.7812500, size.height * 0.3593750);
    path13.arcToPoint(Offset(size.width * 0.7656250, size.height * 0.3437500),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path13.close();
    path13.moveTo(size.width * 0.7500000, size.height * 0.4062500);
    path13.lineTo(size.width * 0.7187500, size.height * 0.4062500);
    path13.lineTo(size.width * 0.7187500, size.height * 0.3750000);
    path13.lineTo(size.width * 0.7500000, size.height * 0.3750000);
    path13.close();

    Paint paint13fill = Paint()..style = PaintingStyle.fill;
    paint13fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path13, paint13fill);

    Path path14 = Path();
    path14.moveTo(size.width * 0.06250000, size.height * 0.6406250);
    path14.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.5937500),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path14.arcToPoint(Offset(size.width * 0.06250000, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path14.close();
    path14.moveTo(size.width * 0.1093750, size.height * 0.6250000);
    path14.arcToPoint(Offset(size.width * 0.09375000, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path14.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.6250000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path14.close();

    Paint paint14fill = Paint()..style = PaintingStyle.fill;
    paint14fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path14, paint14fill);

    Path path15 = Path();
    path15.moveTo(size.width * 0.2187500, size.height * 0.6875000);
    path15.arcToPoint(Offset(size.width * 0.1718750, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path15.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.6875000),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path15.close();
    path15.moveTo(size.width * 0.2187500, size.height * 0.6250000);
    path15.arcToPoint(Offset(size.width * 0.2031250, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path15.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.6250000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path15.close();

    Paint paint15fill = Paint()..style = PaintingStyle.fill;
    paint15fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path15, paint15fill);

    Path path16 = Path();
    path16.moveTo(size.width * 0.3281250, size.height * 0.6875000);
    path16.arcToPoint(Offset(size.width * 0.2812500, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path16.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.6875000),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path16.close();
    path16.moveTo(size.width * 0.3281250, size.height * 0.6250000);
    path16.arcToPoint(Offset(size.width * 0.3125000, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path16.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.6250000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path16.close();

    Paint paint16fill = Paint()..style = PaintingStyle.fill;
    paint16fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path16, paint16fill);

    Path path17 = Path();
    path17.moveTo(size.width * 0.4843750, size.height * 0.6406250);
    path17.lineTo(size.width * 0.6406250, size.height * 0.6406250);
    path17.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.6093750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path17.lineTo(size.width * 0.4843750, size.height * 0.6093750);
    path17.arcToPoint(Offset(size.width * 0.4843750, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path17.close();

    Paint paint17fill = Paint()..style = PaintingStyle.fill;
    paint17fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path17, paint17fill);

    Path path18 = Path();
    path18.moveTo(size.width * 0.6406250, size.height * 0.6562500);
    path18.lineTo(size.width * 0.5625000, size.height * 0.6562500);
    path18.arcToPoint(Offset(size.width * 0.5625000, size.height * 0.6875000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path18.lineTo(size.width * 0.6406250, size.height * 0.6875000);
    path18.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.6562500),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path18.close();

    Paint paint18fill = Paint()..style = PaintingStyle.fill;
    paint18fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path18, paint18fill);

    Path path19 = Path();
    path19.moveTo(size.width * 0.4218750, size.height * 0.6406250);
    path19.lineTo(size.width * 0.4375000, size.height * 0.6406250);
    path19.arcToPoint(Offset(size.width * 0.4375000, size.height * 0.6093750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path19.lineTo(size.width * 0.4218750, size.height * 0.6093750);
    path19.arcToPoint(Offset(size.width * 0.4218750, size.height * 0.6406250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path19.close();

    Paint paint19fill = Paint()..style = PaintingStyle.fill;
    paint19fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path19, paint19fill);

    Path path20 = Path();
    path20.moveTo(size.width * 0.1093750, size.height * 0.3750000);
    path20.arcToPoint(Offset(size.width * 0.1562500, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path20.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.3750000),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path20.close();
    path20.moveTo(size.width * 0.1093750, size.height * 0.4375000);
    path20.arcToPoint(Offset(size.width * 0.1250000, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path20.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.4375000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path20.close();

    Paint paint20fill = Paint()..style = PaintingStyle.fill;
    paint20fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path20, paint20fill);

    Path path21 = Path();
    path21.moveTo(size.width * 0.2187500, size.height * 0.3750000);
    path21.arcToPoint(Offset(size.width * 0.2656250, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path21.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.3750000),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path21.close();
    path21.moveTo(size.width * 0.2187500, size.height * 0.4375000);
    path21.arcToPoint(Offset(size.width * 0.2343750, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path21.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.4375000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path21.close();

    Paint paint21fill = Paint()..style = PaintingStyle.fill;
    paint21fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path21, paint21fill);

    Path path22 = Path();
    path22.moveTo(size.width * 0.3281250, size.height * 0.3750000);
    path22.arcToPoint(Offset(size.width * 0.3750000, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path22.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.3750000),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path22.close();
    path22.moveTo(size.width * 0.3281250, size.height * 0.4375000);
    path22.arcToPoint(Offset(size.width * 0.3437500, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path22.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.4375000),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path22.close();

    Paint paint22fill = Paint()..style = PaintingStyle.fill;
    paint22fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path22, paint22fill);

    Path path23 = Path();
    path23.moveTo(size.width * 0.4375000, size.height * 0.3906250);
    path23.lineTo(size.width * 0.4218750, size.height * 0.3906250);
    path23.arcToPoint(Offset(size.width * 0.4218750, size.height * 0.4218750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path23.lineTo(size.width * 0.4375000, size.height * 0.4218750);
    path23.arcToPoint(Offset(size.width * 0.4375000, size.height * 0.3906250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path23.close();

    Paint paint23fill = Paint()..style = PaintingStyle.fill;
    paint23fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path23, paint23fill);

    Path path24 = Path();
    path24.moveTo(size.width * 0.06250000, size.height * 0.8593750);
    path24.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.8125000),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path24.arcToPoint(Offset(size.width * 0.06250000, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path24.close();
    path24.moveTo(size.width * 0.1093750, size.height * 0.8437500);
    path24.arcToPoint(Offset(size.width * 0.09375000, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path24.arcToPoint(Offset(size.width * 0.1093750, size.height * 0.8437500),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path24.close();

    Paint paint24fill = Paint()..style = PaintingStyle.fill;
    paint24fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path24, paint24fill);

    Path path25 = Path();
    path25.moveTo(size.width * 0.2187500, size.height * 0.9062500);
    path25.arcToPoint(Offset(size.width * 0.1718750, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path25.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.9062500),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path25.close();
    path25.moveTo(size.width * 0.2187500, size.height * 0.8437500);
    path25.arcToPoint(Offset(size.width * 0.2031250, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path25.arcToPoint(Offset(size.width * 0.2187500, size.height * 0.8437500),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path25.close();

    Paint paint25fill = Paint()..style = PaintingStyle.fill;
    paint25fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path25, paint25fill);

    Path path26 = Path();
    path26.moveTo(size.width * 0.3281250, size.height * 0.9062500);
    path26.arcToPoint(Offset(size.width * 0.2812500, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.04687500, size.height * 0.04687500),
        rotation: 0,
        largeArc: true,
        clockwise: false);
    path26.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.9062500),
        radius: Radius.elliptical(
            size.width * 0.04692773, size.height * 0.04692773),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path26.close();
    path26.moveTo(size.width * 0.3281250, size.height * 0.8437500);
    path26.arcToPoint(Offset(size.width * 0.3125000, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: true,
        clockwise: true);
    path26.arcToPoint(Offset(size.width * 0.3281250, size.height * 0.8437500),
        radius: Radius.elliptical(
            size.width * 0.01564258, size.height * 0.01564258),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path26.close();

    Paint paint26fill = Paint()..style = PaintingStyle.fill;
    paint26fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path26, paint26fill);

    Path path27 = Path();
    path27.moveTo(size.width * 0.4843750, size.height * 0.8593750);
    path27.lineTo(size.width * 0.6406250, size.height * 0.8593750);
    path27.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.8281250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path27.lineTo(size.width * 0.4843750, size.height * 0.8281250);
    path27.arcToPoint(Offset(size.width * 0.4843750, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path27.close();

    Paint paint27fill = Paint()..style = PaintingStyle.fill;
    paint27fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path27, paint27fill);

    Path path28 = Path();
    path28.moveTo(size.width * 0.6406250, size.height * 0.8750000);
    path28.lineTo(size.width * 0.5625000, size.height * 0.8750000);
    path28.arcToPoint(Offset(size.width * 0.5625000, size.height * 0.9062500),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path28.lineTo(size.width * 0.6406250, size.height * 0.9062500);
    path28.arcToPoint(Offset(size.width * 0.6406250, size.height * 0.8750000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path28.close();

    Paint paint28fill = Paint()..style = PaintingStyle.fill;
    paint28fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path28, paint28fill);

    Path path29 = Path();
    path29.moveTo(size.width * 0.4218750, size.height * 0.8593750);
    path29.lineTo(size.width * 0.4375000, size.height * 0.8593750);
    path29.arcToPoint(Offset(size.width * 0.4375000, size.height * 0.8281250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path29.lineTo(size.width * 0.4218750, size.height * 0.8281250);
    path29.arcToPoint(Offset(size.width * 0.4218750, size.height * 0.8593750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path29.close();

    Paint paint29fill = Paint()..style = PaintingStyle.fill;
    paint29fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path29, paint29fill);

    Path path30 = Path();
    path30.moveTo(size.width * 0.3593750, size.height * 0.2343750);
    path30.arcToPoint(Offset(size.width * 0.3750000, size.height * 0.2187500),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path30.lineTo(size.width * 0.3750000, size.height * 0.1875000);
    path30.lineTo(size.width * 0.5781250, size.height * 0.1875000);
    path30.arcToPoint(Offset(size.width * 0.5781250, size.height * 0.1562500),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path30.lineTo(size.width * 0.3593750, size.height * 0.1562500);
    path30.arcToPoint(Offset(size.width * 0.3437500, size.height * 0.1718750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path30.lineTo(size.width * 0.3437500, size.height * 0.2187500);
    path30.arcToPoint(Offset(size.width * 0.3593750, size.height * 0.2343750),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path30.close();

    Paint paint30fill = Paint()..style = PaintingStyle.fill;
    paint30fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path30, paint30fill);

    Path path31 = Path();
    path31.moveTo(size.width * 0.7968750, size.height * 0.5000000);
    path31.arcToPoint(Offset(size.width * 0.7812500, size.height * 0.5156250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path31.lineTo(size.width * 0.7812500, size.height * 0.8593750);
    path31.lineTo(size.width * 0.7343750, size.height * 0.8593750);
    path31.arcToPoint(Offset(size.width * 0.7343750, size.height * 0.8906250),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path31.lineTo(size.width * 0.7968750, size.height * 0.8906250);
    path31.arcToPoint(Offset(size.width * 0.8125000, size.height * 0.8750000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path31.lineTo(size.width * 0.8125000, size.height * 0.5156250);
    path31.arcToPoint(Offset(size.width * 0.7968750, size.height * 0.5000000),
        radius: Radius.elliptical(
            size.width * 0.01562500, size.height * 0.01562500),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path31.close();

    Paint paint31fill = Paint()..style = PaintingStyle.fill;
    paint31fill.color = Color(0xff004fac).withOpacity(1.0);
    canvas.drawPath(path31, paint31fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
