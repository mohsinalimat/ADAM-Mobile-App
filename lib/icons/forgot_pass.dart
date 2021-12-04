import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ForgotIconPainter extends CustomPainter {
  final Color color;

  ForgotIconPainter({this.color});
  static Size size(num width) => Size(
        width,
        (width * 0.9).toDouble(),
      );

  Size getSize(num width) => ForgotIconPainter.size(width);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2498770, size.height * 0.6367188);
    path_0.cubicTo(
        size.width * 0.2714512,
        size.height * 0.6367188,
        size.width * 0.2889395,
        size.height * 0.6542070,
        size.width * 0.2889395,
        size.height * 0.6757813);
    path_0.lineTo(size.width * 0.2889395, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.2889395,
        size.height * 0.6973555,
        size.width * 0.2714512,
        size.height * 0.7148438,
        size.width * 0.2498770,
        size.height * 0.7148438);
    path_0.cubicTo(
        size.width * 0.2283027,
        size.height * 0.7148438,
        size.width * 0.2108145,
        size.height * 0.6973555,
        size.width * 0.2108145,
        size.height * 0.6757813);
    path_0.lineTo(size.width * 0.2108145, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.2108145,
        size.height * 0.6542070,
        size.width * 0.2283027,
        size.height * 0.6367188,
        size.width * 0.2498770,
        size.height * 0.6367188);
    path_0.close();
    path_0.moveTo(size.width * 0.3572988, size.height * 0.6757813);
    path_0.lineTo(size.width * 0.3572988, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.3572988,
        size.height * 0.6973555,
        size.width * 0.3747871,
        size.height * 0.7148438,
        size.width * 0.3963613,
        size.height * 0.7148438);
    path_0.cubicTo(
        size.width * 0.4179355,
        size.height * 0.7148438,
        size.width * 0.4354238,
        size.height * 0.6973555,
        size.width * 0.4354238,
        size.height * 0.6757813);
    path_0.lineTo(size.width * 0.4354238, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.4354238,
        size.height * 0.6542070,
        size.width * 0.4179355,
        size.height * 0.6367188,
        size.width * 0.3963613,
        size.height * 0.6367188);
    path_0.cubicTo(
        size.width * 0.3747871,
        size.height * 0.6367188,
        size.width * 0.3572988,
        size.height * 0.6542070,
        size.width * 0.3572988,
        size.height * 0.6757813);
    path_0.close();
    path_0.moveTo(size.width * 0.5037832, size.height * 0.6757813);
    path_0.lineTo(size.width * 0.5037832, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.5037832,
        size.height * 0.6973555,
        size.width * 0.5212715,
        size.height * 0.7148438,
        size.width * 0.5428457,
        size.height * 0.7148438);
    path_0.cubicTo(
        size.width * 0.5644199,
        size.height * 0.7148438,
        size.width * 0.5819082,
        size.height * 0.6973555,
        size.width * 0.5819082,
        size.height * 0.6757813);
    path_0.lineTo(size.width * 0.5819082, size.height * 0.6757813);
    path_0.cubicTo(
        size.width * 0.5819082,
        size.height * 0.6542070,
        size.width * 0.5644199,
        size.height * 0.6367188,
        size.width * 0.5428457,
        size.height * 0.6367188);
    path_0.cubicTo(
        size.width * 0.5212715,
        size.height * 0.6367188,
        size.width * 0.5037832,
        size.height * 0.6542070,
        size.width * 0.5037832,
        size.height * 0.6757813);
    path_0.close();
    path_0.moveTo(size.width * 0.7127676, size.height * 0.9609375);
    path_0.cubicTo(
        size.width * 0.7127676,
        size.height * 0.9825117,
        size.width * 0.6952793,
        size.height,
        size.width * 0.6737051,
        size.height);
    path_0.lineTo(size.width * 0.1873770, size.height);
    path_0.cubicTo(
        size.width * 0.1012207,
        size.height,
        size.width * 0.03112695,
        size.height * 0.9299063,
        size.width * 0.03112695,
        size.height * 0.8437500);
    path_0.lineTo(size.width * 0.03112695, size.height * 0.5234375);
    path_0.cubicTo(
        size.width * 0.03112695,
        size.height * 0.4372813,
        size.width * 0.1012207,
        size.height * 0.3671875,
        size.width * 0.1873770,
        size.height * 0.3671875);
    path_0.lineTo(size.width * 0.2341797, size.height * 0.3671875);
    path_0.lineTo(size.width * 0.2341797, size.height * 0.2294258);
    path_0.cubicTo(size.width * 0.2341797, size.height * 0.1029199,
        size.width * 0.3393203, 0, size.width * 0.4685547, 0);
    path_0.cubicTo(
        size.width * 0.5977891,
        0,
        size.width * 0.7029297,
        size.height * 0.1029199,
        size.width * 0.7029297,
        size.height * 0.2294258);
    path_0.lineTo(size.width * 0.7029297, size.height * 0.3671875);
    path_0.lineTo(size.width * 0.7498770, size.height * 0.3671875);
    path_0.cubicTo(
        size.width * 0.7661543,
        size.height * 0.3671875,
        size.width * 0.7802500,
        size.height * 0.3689590,
        size.width * 0.7929707,
        size.height * 0.3726035);
    path_0.cubicTo(
        size.width * 0.8137090,
        size.height * 0.3785469,
        size.width * 0.8257051,
        size.height * 0.4001758,
        size.width * 0.8197637,
        size.height * 0.4209141);
    path_0.cubicTo(
        size.width * 0.8138203,
        size.height * 0.4416523,
        size.width * 0.7921914,
        size.height * 0.4536484,
        size.width * 0.7714531,
        size.height * 0.4477070);
    path_0.cubicTo(
        size.width * 0.7658281,
        size.height * 0.4460957,
        size.width * 0.7587715,
        size.height * 0.4453105,
        size.width * 0.7498770,
        size.height * 0.4453105);
    path_0.lineTo(size.width * 0.1873770, size.height * 0.4453105);
    path_0.cubicTo(
        size.width * 0.1442988,
        size.height * 0.4453105,
        size.width * 0.1092520,
        size.height * 0.4803574,
        size.width * 0.1092520,
        size.height * 0.5234355);
    path_0.lineTo(size.width * 0.1092520, size.height * 0.8437480);
    path_0.cubicTo(
        size.width * 0.1092520,
        size.height * 0.8868262,
        size.width * 0.1442988,
        size.height * 0.9218730,
        size.width * 0.1873770,
        size.height * 0.9218730);
    path_0.lineTo(size.width * 0.6737051, size.height * 0.9218730);
    path_0.cubicTo(
        size.width * 0.6952793,
        size.height * 0.9218750,
        size.width * 0.7127676,
        size.height * 0.9393633,
        size.width * 0.7127676,
        size.height * 0.9609375);
    path_0.close();
    path_0.moveTo(size.width * 0.3123047, size.height * 0.3671875);
    path_0.lineTo(size.width * 0.6248047, size.height * 0.3671875);
    path_0.lineTo(size.width * 0.6248047, size.height * 0.2294258);
    path_0.cubicTo(
        size.width * 0.6248047,
        size.height * 0.1459980,
        size.width * 0.5547109,
        size.height * 0.07812500,
        size.width * 0.4685547,
        size.height * 0.07812500);
    path_0.cubicTo(
        size.width * 0.3823984,
        size.height * 0.07812500,
        size.width * 0.3123047,
        size.height * 0.1459980,
        size.width * 0.3123047,
        size.height * 0.2294258);
    path_0.lineTo(size.width * 0.3123047, size.height * 0.3671875);
    path_0.close();
    path_0.moveTo(size.width * 0.8299551, size.height * 0.9218750);
    path_0.lineTo(size.width * 0.8299551, size.height * 0.9218750);
    path_0.cubicTo(
        size.width * 0.8083809,
        size.height * 0.9218750,
        size.width * 0.7908926,
        size.height * 0.9393633,
        size.width * 0.7908926,
        size.height * 0.9609375);
    path_0.cubicTo(
        size.width * 0.7908926,
        size.height * 0.9825117,
        size.width * 0.8083809,
        size.height,
        size.width * 0.8299551,
        size.height);
    path_0.lineTo(size.width * 0.8299551, size.height);
    path_0.cubicTo(
        size.width * 0.8515293,
        size.height,
        size.width * 0.8690176,
        size.height * 0.9825117,
        size.width * 0.8690176,
        size.height * 0.9609375);
    path_0.cubicTo(
        size.width * 0.8690176,
        size.height * 0.9393633,
        size.width * 0.8515293,
        size.height * 0.9218750,
        size.width * 0.8299551,
        size.height * 0.9218750);
    path_0.close();
    path_0.moveTo(size.width * 0.9688398, size.height * 0.6468945);
    path_0.cubicTo(
        size.width * 0.9679844,
        size.height * 0.5711348,
        size.width * 0.9060859,
        size.height * 0.5097656,
        size.width * 0.8301270,
        size.height * 0.5097656);
    path_0.cubicTo(
        size.width * 0.7536387,
        size.height * 0.5097656,
        size.width * 0.6914063,
        size.height * 0.5719961,
        size.width * 0.6914063,
        size.height * 0.6484863);
    path_0.cubicTo(
        size.width * 0.6914063,
        size.height * 0.6700605,
        size.width * 0.7088945,
        size.height * 0.6875488,
        size.width * 0.7304688,
        size.height * 0.6875488);
    path_0.cubicTo(
        size.width * 0.7520430,
        size.height * 0.6875488,
        size.width * 0.7695313,
        size.height * 0.6700605,
        size.width * 0.7695313,
        size.height * 0.6484863);
    path_0.cubicTo(
        size.width * 0.7695313,
        size.height * 0.6150742,
        size.width * 0.7967148,
        size.height * 0.5878906,
        size.width * 0.8301289,
        size.height * 0.5878906);
    path_0.cubicTo(
        size.width * 0.8635430,
        size.height * 0.5878906,
        size.width * 0.8907246,
        size.height * 0.6150742,
        size.width * 0.8907246,
        size.height * 0.6484863);
    path_0.cubicTo(
        size.width * 0.8907246,
        size.height * 0.6488418,
        size.width * 0.8907285,
        size.height * 0.6491953,
        size.width * 0.8907383,
        size.height * 0.6495469);
    path_0.cubicTo(
        size.width * 0.8903359,
        size.height * 0.6734668,
        size.width * 0.8759668,
        size.height * 0.6948809,
        size.width * 0.8538945,
        size.height * 0.7043027);
    path_0.cubicTo(
        size.width * 0.8157285,
        size.height * 0.7206016,
        size.width * 0.7910664,
        size.height * 0.7582441,
        size.width * 0.7910664,
        size.height * 0.8002031);
    path_0.lineTo(size.width * 0.7910664, size.height * 0.8339844);
    path_0.cubicTo(
        size.width * 0.7910664,
        size.height * 0.8555586,
        size.width * 0.8085547,
        size.height * 0.8730469,
        size.width * 0.8301289,
        size.height * 0.8730469);
    path_0.cubicTo(
        size.width * 0.8517031,
        size.height * 0.8730469,
        size.width * 0.8691914,
        size.height * 0.8555586,
        size.width * 0.8691914,
        size.height * 0.8339844);
    path_0.lineTo(size.width * 0.8691914, size.height * 0.8002031);
    path_0.cubicTo(
        size.width * 0.8691914,
        size.height * 0.7895820,
        size.width * 0.8752305,
        size.height * 0.7801426,
        size.width * 0.8845723,
        size.height * 0.7761543);
    path_0.cubicTo(
        size.width * 0.9357969,
        size.height * 0.7542871,
        size.width * 0.9688867,
        size.height * 0.7041719,
        size.width * 0.9688730,
        size.height * 0.6484785);
    path_0.cubicTo(
        size.width * 0.9688730,
        size.height * 0.6479473,
        size.width * 0.9688613,
        size.height * 0.6474199,
        size.width * 0.9688398,
        size.height * 0.6468945);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.03112695, size.height * 0.5039063),
        Offset(size.width * 0.9688730, size.height * 0.5039063), [
      Color(0xff00F2FE).withOpacity(1.0),
      Color(0xff03EFFE).withOpacity(1.0),
      Color(0xff24D2FE).withOpacity(1.0),
      Color(0xff3CBDFE).withOpacity(1.0),
      Color(0xff4AB0FE).withOpacity(1.0),
      Color(0xff4FACFE).withOpacity(1.0)
    ], [
      0,
      0.021,
      0.293,
      0.554,
      0.796,
      1
    ]);
    canvas.drawPath(path_0, paint0fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
