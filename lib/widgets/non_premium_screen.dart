import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NonPremiumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/premium.svg', height: 150),
            const SizedBox(height: 20.0),
            Text(
              "Buy Premium Subscription!",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 8.0),
            const Text(
                "Account schedulers are available only for Premium Members!")
          ],
        ),
      ),
    );
  }
}
