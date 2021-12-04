import 'package:adam/constants.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderYourServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      width: 260,
      child: Card(
        child: Column(children: [
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              period: Duration(seconds: 1),
              baseColor: Colors.white,
              highlightColor: Colors.blueGrey[100],
              child: Diagonal(
                clipHeight: 20.0,
                axis: Axis.vertical,
                position: DiagonalPosition.TOP_RIGHT,
                child: Container(
                  height: 30.0,
                  width: 150,
                  color: Colors.white,
                  child: Center(
                    child: Text(""),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 1),
                    baseColor: Colors.white,
                    highlightColor: Colors.blueGrey[100],
                    child: Container(
                      color: Colors.white,
                      // color: kPrimaryBlueColor,
                      height: 60.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(""),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Shimmer.fromColors(
            period: Duration(seconds: 1),
            baseColor: Colors.white,
            highlightColor: Colors.blueGrey[100],
            child: CustomButton(
              btnWidth: 200,
              btnHeight: 40.0,
              btnOnPressed: () {},
              btnColor: kPrimaryBlueColor,
              btnText: Text(
                "",
                style: kBtnTextStyle,
              ),
            ),
          ),
          SizedBox(height: 30.0),
        ]),
      ),
    );
  }
}
