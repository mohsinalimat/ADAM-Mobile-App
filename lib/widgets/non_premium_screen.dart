import 'package:adam/icons/premium_icon.dart';
import 'package:flutter/material.dart';

class NonPremiumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: PremiumIconPainter.size(
                  MediaQuery.of(context).size.width * 0.5,
                ),
                painter: PremiumIconPainter(),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Buy Premium Subscription!",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Account schedulers are available only for Premium Members!",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
