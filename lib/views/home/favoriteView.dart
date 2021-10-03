import 'package:adam/controller/serviceController.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    const LogoDisplay(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Favorite Services",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 5.0),
                const Text("Keep an eye on your favorites!"),
                const SizedBox(height: 20.0),
                FutureBuilder(
                  future: ServiceController().viewFavorite(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Text('snapshot.data.services[0].serviceName.toString()'),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 24.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
