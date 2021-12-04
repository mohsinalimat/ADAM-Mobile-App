import 'package:flutter/material.dart';

class DeleteIconPainter extends CustomPainter {
  static Size size(num width) => Size(
        width,
        (width * 0.9).toDouble(),
      );

  Size getSize(num width) => DeleteIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8318565, size.height * 0.8981588);
    path_0.lineTo(size.width * 0.8318565, size.height * 0.9827607);
    path_0.cubicTo(
        size.width * 0.8318565,
        size.height * 0.9922854,
        size.width * 0.8241419,
        size.height,
        size.width * 0.8146172,
        size.height);
    path_0.lineTo(size.width * 0.1853828, size.height);
    path_0.cubicTo(
        size.width * 0.1758581,
        size.height,
        size.width * 0.1681435,
        size.height * 0.9922854,
        size.width * 0.1681435,
        size.height * 0.9827607);
    path_0.lineTo(size.width * 0.1681435, size.height * 0.8981588);
    path_0.cubicTo(
        size.width * 0.1681435,
        size.height * 0.8093980,
        size.width * 0.2400960,
        size.height * 0.7374886,
        size.width * 0.3288784,
        size.height * 0.7374670);
    path_0.cubicTo(
        size.width * 0.3602539,
        size.height * 0.7374455,
        size.width * 0.3878799,
        size.height * 0.7213052,
        size.width * 0.4037832,
        size.height * 0.6968254);
    path_0.cubicTo(
        size.width * 0.4197597,
        size.height * 0.6722723,
        size.width * 0.4181133,
        size.height * 0.6509214,
        size.width * 0.4181133,
        size.height * 0.6336649);
    path_0.lineTo(size.width * 0.4184366, size.height * 0.6328676);
    path_0.cubicTo(
        size.width * 0.3410752,
        size.height * 0.6008456,
        size.width * 0.2866637,
        size.height * 0.5246263,
        size.width * 0.2866637,
        size.height * 0.4356931);
    path_0.lineTo(size.width * 0.2866637, size.height * 0.4289482);
    path_0.cubicTo(
        size.width * 0.2559454,
        size.height * 0.4289482,
        size.width * 0.2327909,
        size.height * 0.4046731,
        size.width * 0.2327909,
        size.height * 0.3760667);
    path_0.lineTo(size.width * 0.2327909, size.height * 0.2865085);
    path_0.cubicTo(
        size.width * 0.2321013,
        size.height * 0.2553269,
        size.width * 0.2335235,
        size.height * 0.1453618,
        size.width * 0.3129536,
        size.height * 0.06879773);
    path_0.cubicTo(
        size.width * 0.4053132,
        size.height * -0.02022170,
        size.width * 0.5516748,
        size.height * -0.01293809,
        size.width * 0.6576965,
        size.height * 0.03468547);
    path_0.cubicTo(
        size.width * 0.6611443,
        size.height * 0.03623701,
        size.width * 0.6610366,
        size.height * 0.04117176,
        size.width * 0.6575456,
        size.height * 0.04261555);
    path_0.lineTo(size.width * 0.6298981, size.height * 0.05399348);
    path_0.cubicTo(
        size.width * 0.6257607,
        size.height * 0.05569586,
        size.width * 0.6266442,
        size.height * 0.06179427,
        size.width * 0.6310833,
        size.height * 0.06226835);
    path_0.lineTo(size.width * 0.6445084, size.height * 0.06371214);
    path_0.cubicTo(
        size.width * 0.7087895,
        size.height * 0.07058631,
        size.width * 0.7685021,
        size.height * 0.1054959,
        size.width * 0.8055235,
        size.height * 0.1635923);
    path_0.cubicTo(
        size.width * 0.8065147,
        size.height * 0.1651654,
        size.width * 0.8062346,
        size.height * 0.1675574,
        size.width * 0.8049632,
        size.height * 0.1689150);
    path_0.cubicTo(
        size.width * 0.7821211,
        size.height * 0.1930715,
        size.width * 0.7693640,
        size.height * 0.2251366,
        size.width * 0.7693640,
        size.height * 0.2584731);
    path_0.lineTo(size.width * 0.7693640, size.height * 0.3760667);
    path_0.cubicTo(
        size.width * 0.7693640,
        size.height * 0.4052657,
        size.width * 0.7456816,
        size.height * 0.4289482,
        size.width * 0.7164825,
        size.height * 0.4289482);
    path_0.lineTo(size.width * 0.7133363, size.height * 0.4289482);
    path_0.lineTo(size.width * 0.7133363, size.height * 0.4356931);
    path_0.cubicTo(
        size.width * 0.7133363,
        size.height * 0.5246263,
        size.width * 0.6589248,
        size.height * 0.6008456,
        size.width * 0.5815634,
        size.height * 0.6328676);
    path_0.lineTo(size.width * 0.5818867, size.height * 0.6336649);
    path_0.cubicTo(
        size.width * 0.5818867,
        size.height * 0.6504237,
        size.width * 0.5801046,
        size.height * 0.6720654,
        size.width * 0.5962168,
        size.height * 0.6968254);
    path_0.cubicTo(
        size.width * 0.6121201,
        size.height * 0.7213052,
        size.width * 0.6397461,
        size.height * 0.7374455,
        size.width * 0.6711216,
        size.height * 0.7374670);
    path_0.cubicTo(
        size.width * 0.7599040,
        size.height * 0.7374886,
        size.width * 0.8318565,
        size.height * 0.8093980,
        size.width * 0.8318565,
        size.height * 0.8981588);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0xffffdfba).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.8318565, size.height * 0.8981588);
    path_1.lineTo(size.width * 0.8318565, size.height * 0.9827607);
    path_1.cubicTo(
        size.width * 0.8318565,
        size.height * 0.9922811,
        size.width * 0.8241376,
        size.height,
        size.width * 0.8146172,
        size.height);
    path_1.lineTo(size.width * 0.1853828, size.height);
    path_1.cubicTo(
        size.width * 0.1758624,
        size.height,
        size.width * 0.1681435,
        size.height * 0.9922811,
        size.width * 0.1681435,
        size.height * 0.9827607);
    path_1.lineTo(size.width * 0.1681435, size.height * 0.8981588);
    path_1.cubicTo(
        size.width * 0.1681435,
        size.height * 0.8093980,
        size.width * 0.2401068,
        size.height * 0.7374994,
        size.width * 0.3288676,
        size.height * 0.7374670);
    path_1.cubicTo(
        size.width * 0.3602518,
        size.height * 0.7374563,
        size.width * 0.3878842,
        size.height * 0.7212966,
        size.width * 0.4037832,
        size.height * 0.6968254);
    path_1.cubicTo(
        size.width * 0.4592808,
        size.height * 0.7442378,
        size.width * 0.5406869,
        size.height * 0.7442658,
        size.width * 0.5962168,
        size.height * 0.6968254);
    path_1.cubicTo(
        size.width * 0.6121136,
        size.height * 0.7212966,
        size.width * 0.6397482,
        size.height * 0.7374563,
        size.width * 0.6711324,
        size.height * 0.7374670);
    path_1.cubicTo(
        size.width * 0.7598932,
        size.height * 0.7374994,
        size.width * 0.8318565,
        size.height * 0.8093980,
        size.width * 0.8318565,
        size.height * 0.8981588);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Color(0xfffe4f60).withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.8055149, size.height * 0.1636031);
    path_2.cubicTo(
        size.width * 0.8065147,
        size.height * 0.1651740,
        size.width * 0.8062346,
        size.height * 0.1675531,
        size.width * 0.8049567,
        size.height * 0.1689063);
    path_2.cubicTo(
        size.width * 0.7821211,
        size.height * 0.1930801,
        size.width * 0.7693640,
        size.height * 0.2251345,
        size.width * 0.7693640,
        size.height * 0.2584731);
    path_2.lineTo(size.width * 0.7693640, size.height * 0.3760667);
    path_2.cubicTo(
        size.width * 0.7693640,
        size.height * 0.4027617,
        size.width * 0.7492522,
        size.height * 0.4289482,
        size.width * 0.7133363,
        size.height * 0.4289482);
    path_2.lineTo(size.width * 0.7133363, size.height * 0.2958393);
    path_2.cubicTo(
        size.width * 0.7133363,
        size.height * 0.2387126,
        size.width * 0.6670273,
        size.height * 0.1924035,
        size.width * 0.6099005,
        size.height * 0.1924035);
    path_2.lineTo(size.width * 0.3900995, size.height * 0.1924035);
    path_2.cubicTo(
        size.width * 0.3329727,
        size.height * 0.1924035,
        size.width * 0.2866637,
        size.height * 0.2387126,
        size.width * 0.2866637,
        size.height * 0.2958393);
    path_2.lineTo(size.width * 0.2866637, size.height * 0.4289482);
    path_2.cubicTo(
        size.width * 0.2559454,
        size.height * 0.4289482,
        size.width * 0.2327909,
        size.height * 0.4046731,
        size.width * 0.2327909,
        size.height * 0.3760667);
    path_2.lineTo(size.width * 0.2327909, size.height * 0.2865085);
    path_2.cubicTo(
        size.width * 0.2321013,
        size.height * 0.2553269,
        size.width * 0.2335235,
        size.height * 0.1453618,
        size.width * 0.3129536,
        size.height * 0.06879773);
    path_2.cubicTo(
        size.width * 0.4053067,
        size.height * -0.02022385,
        size.width * 0.5516834,
        size.height * -0.01293594,
        size.width * 0.6576879,
        size.height * 0.03469193);
    path_2.cubicTo(
        size.width * 0.6611357,
        size.height * 0.03624132,
        size.width * 0.6610452,
        size.height * 0.04117822,
        size.width * 0.6575478,
        size.height * 0.04261770);
    path_2.lineTo(size.width * 0.6298981, size.height * 0.05399995);
    path_2.cubicTo(
        size.width * 0.6257650,
        size.height * 0.05570233,
        size.width * 0.6266356,
        size.height * 0.06179427,
        size.width * 0.6310790,
        size.height * 0.06227050);
    path_2.lineTo(size.width * 0.6445084, size.height * 0.06371214);
    path_2.cubicTo(
        size.width * 0.7088002,
        size.height * 0.07057984,
        size.width * 0.7684978,
        size.height * 0.1054894,
        size.width * 0.8055149,
        size.height * 0.1636031);
    path_2.close();

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = Color(0xff42434d).withOpacity(1.0);
    canvas.drawPath(path_2, paint2fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.7133363, size.height * 0.4356931);
    path_3.cubicTo(
        size.width * 0.7133363,
        size.height * 0.5535582,
        size.width * 0.6177703,
        size.height * 0.6490294,
        size.width * 0.5000000,
        size.height * 0.6490294);
    path_3.cubicTo(
        size.width * 0.3890393,
        size.height * 0.6490294,
        size.width * 0.2866637,
        size.height * 0.5627661,
        size.width * 0.2866637,
        size.height * 0.4289482);
    path_3.lineTo(size.width * 0.2866637, size.height * 0.2958393);
    path_3.cubicTo(
        size.width * 0.2866637,
        size.height * 0.2387126,
        size.width * 0.3329727,
        size.height * 0.1924035,
        size.width * 0.3900995,
        size.height * 0.1924035);
    path_3.lineTo(size.width * 0.6099005, size.height * 0.1924035);
    path_3.cubicTo(
        size.width * 0.6670273,
        size.height * 0.1924035,
        size.width * 0.7133363,
        size.height * 0.2387126,
        size.width * 0.7133363,
        size.height * 0.2958393);
    path_3.close();

    Paint paint3fill = Paint()..style = PaintingStyle.fill;
    paint3fill.color = Color(0xffffebd2).withOpacity(1.0);
    canvas.drawPath(path_3, paint3fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6745479, size.height * 0.9633665);
    path_4.lineTo(size.width * 0.6228300, size.height * 0.9633665);
    path_4.cubicTo(
        size.width * 0.6133096,
        size.height * 0.9633665,
        size.width * 0.6055907,
        size.height * 0.9556476,
        size.width * 0.6055907,
        size.height * 0.9461272);
    path_4.cubicTo(
        size.width * 0.6055907,
        size.height * 0.9366068,
        size.width * 0.6133096,
        size.height * 0.9288879,
        size.width * 0.6228300,
        size.height * 0.9288879);
    path_4.lineTo(size.width * 0.6745479, size.height * 0.9288879);
    path_4.cubicTo(
        size.width * 0.6840683,
        size.height * 0.9288879,
        size.width * 0.6917872,
        size.height * 0.9366068,
        size.width * 0.6917872,
        size.height * 0.9461272);
    path_4.cubicTo(
        size.width * 0.6917872,
        size.height * 0.9556476,
        size.width * 0.6840705,
        size.height * 0.9633665,
        size.width * 0.6745479,
        size.height * 0.9633665);
    path_4.close();

    Paint paint4fill = Paint()..style = PaintingStyle.fill;
    paint4fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_4, paint4fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4516955, size.height * 0.5734523);
    path_5.cubicTo(
        size.width * 0.4867710,
        size.height * 0.5953958,
        size.width * 0.4591127,
        size.height * 0.6492104,
        size.width * 0.4207165,
        size.height * 0.6337985);
    path_5.cubicTo(
        size.width * 0.3417734,
        size.height * 0.6021127,
        size.width * 0.2866637,
        size.height * 0.5251823,
        size.width * 0.2866637,
        size.height * 0.4356931);
    path_5.lineTo(size.width * 0.2866637, size.height * 0.2958393);
    path_5.cubicTo(
        size.width * 0.2866637,
        size.height * 0.2741092,
        size.width * 0.2933655,
        size.height * 0.2539435,
        size.width * 0.3048124,
        size.height * 0.2372946);
    path_5.cubicTo(
        size.width * 0.3188494,
        size.height * 0.2168812,
        size.width * 0.3513110,
        size.height * 0.2258995,
        size.width * 0.3513110,
        size.height * 0.2527410);
    path_5.lineTo(size.width * 0.3513110, size.height * 0.3925949);
    path_5.cubicTo(
        size.width * 0.3513110,
        size.height * 0.4712707,
        size.width * 0.3926681,
        size.height * 0.5365215,
        size.width * 0.4516955,
        size.height * 0.5734523);
    path_5.close();

    Paint paint5fill = Paint()..style = PaintingStyle.fill;
    paint5fill.color = Color(0xfffff3e4).withOpacity(1.0);
    canvas.drawPath(path_5, paint5fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.5843217, size.height * 0.6690486);
    path_6.cubicTo(
        size.width * 0.5312311,
        size.height * 0.6912722,
        size.width * 0.4728869,
        size.height * 0.6929961,
        size.width * 0.4156783,
        size.height * 0.6690486);
    path_6.cubicTo(
        size.width * 0.4186003,
        size.height * 0.6569250,
        size.width * 0.4181133,
        size.height * 0.6490725,
        size.width * 0.4181133,
        size.height * 0.6336649);
    path_6.lineTo(size.width * 0.4184366, size.height * 0.6328676);
    path_6.cubicTo(
        size.width * 0.4703312,
        size.height * 0.6544081,
        size.width * 0.5295676,
        size.height * 0.6544512,
        size.width * 0.5815634,
        size.height * 0.6328676);
    path_6.lineTo(size.width * 0.5818867, size.height * 0.6336649);
    path_6.cubicTo(
        size.width * 0.5818867,
        size.height * 0.6490790,
        size.width * 0.5813997,
        size.height * 0.6569293,
        size.width * 0.5843217,
        size.height * 0.6690486);
    path_6.close();

    Paint paint6fill = Paint()..style = PaintingStyle.fill;
    paint6fill.color = Color(0xffffd6a6).withOpacity(1.0);
    canvas.drawPath(path_6, paint6fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.4157041, size.height * 0.7895232);
    path_7.cubicTo(
        size.width * 0.4077353,
        size.height * 0.7920294,
        size.width * 0.3991889,
        size.height * 0.7934107,
        size.width * 0.3900262,
        size.height * 0.7934904);
    path_7.cubicTo(
        size.width * 0.3010369,
        size.height * 0.7942748,
        size.width * 0.2284810,
        size.height * 0.8646392,
        size.width * 0.2284810,
        size.height * 0.9536328);
    path_7.lineTo(size.width * 0.2284810, size.height * 0.9698312);
    path_7.cubicTo(
        size.width * 0.2284810,
        size.height * 0.9864930,
        size.width * 0.2149741,
        size.height,
        size.width * 0.1983123,
        size.height);
    path_7.lineTo(size.width * 0.1853828, size.height);
    path_7.cubicTo(
        size.width * 0.1758624,
        size.height,
        size.width * 0.1681435,
        size.height * 0.9922811,
        size.width * 0.1681435,
        size.height * 0.9827607);
    path_7.lineTo(size.width * 0.1681435, size.height * 0.8981588);
    path_7.cubicTo(
        size.width * 0.1681435,
        size.height * 0.8093958,
        size.width * 0.2401068,
        size.height * 0.7374994,
        size.width * 0.3288676,
        size.height * 0.7374670);
    path_7.cubicTo(
        size.width * 0.3602518,
        size.height * 0.7374563,
        size.width * 0.3878842,
        size.height * 0.7212966,
        size.width * 0.4037832,
        size.height * 0.6968254);
    path_7.cubicTo(
        size.width * 0.4101919,
        size.height * 0.7022989,
        size.width * 0.4170531,
        size.height * 0.7072185,
        size.width * 0.4242807,
        size.height * 0.7115262);
    path_7.cubicTo(
        size.width * 0.4560721,
        size.height * 0.7304700,
        size.width * 0.4510059,
        size.height * 0.7784233,
        size.width * 0.4157041,
        size.height * 0.7895232);
    path_7.close();

    Paint paint7fill = Paint()..style = PaintingStyle.fill;
    paint7fill.color = Color(0xffff6d7a).withOpacity(1.0);
    canvas.drawPath(path_7, paint7fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.5842959, size.height * 0.7895232);
    path_8.cubicTo(
        size.width * 0.5922647,
        size.height * 0.7920294,
        size.width * 0.6008111,
        size.height * 0.7934107,
        size.width * 0.6099738,
        size.height * 0.7934904);
    path_8.cubicTo(
        size.width * 0.6989631,
        size.height * 0.7942748,
        size.width * 0.7715190,
        size.height * 0.8646392,
        size.width * 0.7715190,
        size.height * 0.9536328);
    path_8.lineTo(size.width * 0.7715190, size.height * 0.9698312);
    path_8.cubicTo(
        size.width * 0.7715190,
        size.height * 0.9864930,
        size.width * 0.7850259,
        size.height,
        size.width * 0.8016877,
        size.height);
    path_8.lineTo(size.width * 0.8146172, size.height);
    path_8.cubicTo(
        size.width * 0.8241376,
        size.height,
        size.width * 0.8318565,
        size.height * 0.9922811,
        size.width * 0.8318565,
        size.height * 0.9827607);
    path_8.lineTo(size.width * 0.8318565, size.height * 0.8981588);
    path_8.cubicTo(
        size.width * 0.8318565,
        size.height * 0.8093958,
        size.width * 0.7598932,
        size.height * 0.7374994,
        size.width * 0.6711324,
        size.height * 0.7374670);
    path_8.cubicTo(
        size.width * 0.6397482,
        size.height * 0.7374563,
        size.width * 0.6121158,
        size.height * 0.7212966,
        size.width * 0.5962168,
        size.height * 0.6968254);
    path_8.cubicTo(
        size.width * 0.5898081,
        size.height * 0.7022989,
        size.width * 0.5829469,
        size.height * 0.7072185,
        size.width * 0.5757193,
        size.height * 0.7115262);
    path_8.cubicTo(
        size.width * 0.5439300,
        size.height * 0.7304700,
        size.width * 0.5489941,
        size.height * 0.7784233,
        size.width * 0.5842959,
        size.height * 0.7895232);
    path_8.close();

    Paint paint8fill = Paint()..style = PaintingStyle.fill;
    paint8fill.color = Color(0xffe84857).withOpacity(1.0);
    canvas.drawPath(path_8, paint8fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.6575456, size.height * 0.04261555);
    path_9.cubicTo(
        size.width * 0.6322082,
        size.height * 0.05304317,
        size.width * 0.6285965,
        size.height * 0.05534246,
        size.width * 0.6198174,
        size.height * 0.05398055);
    path_9.cubicTo(
        size.width * 0.4782957,
        size.height * 0.03204355,
        size.width * 0.3541297,
        size.height * 0.09059898,
        size.width * 0.3119623,
        size.height * 0.2280673);
    path_9.lineTo(size.width * 0.3119623, size.height * 0.2280889);
    path_9.cubicTo(
        size.width * 0.2961884,
        size.height * 0.2462332,
        size.width * 0.2866637,
        size.height * 0.2699372,
        size.width * 0.2866637,
        size.height * 0.2958393);
    path_9.lineTo(size.width * 0.2866637, size.height * 0.3766981);
    path_9.cubicTo(
        size.width * 0.2866637,
        size.height * 0.4115818,
        size.width * 0.2327909,
        size.height * 0.4140104,
        size.width * 0.2327909,
        size.height * 0.3760667);
    path_9.lineTo(size.width * 0.2327909, size.height * 0.2865085);
    path_9.cubicTo(
        size.width * 0.2321013,
        size.height * 0.2553269,
        size.width * 0.2335235,
        size.height * 0.1453618,
        size.width * 0.3129536,
        size.height * 0.06879773);
    path_9.cubicTo(
        size.width * 0.4053132,
        size.height * -0.02022170,
        size.width * 0.5516748,
        size.height * -0.01293809,
        size.width * 0.6576965,
        size.height * 0.03468547);
    path_9.cubicTo(
        size.width * 0.6611443,
        size.height * 0.03623701,
        size.width * 0.6610366,
        size.height * 0.04117176,
        size.width * 0.6575456,
        size.height * 0.04261555);
    path_9.close();

    Paint paint9fill = Paint()..style = PaintingStyle.fill;
    paint9fill.color = Color(0xff4d4e59).withOpacity(1.0);
    canvas.drawPath(path_9, paint9fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
