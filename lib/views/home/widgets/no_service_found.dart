import 'package:flutter/material.dart';

class NoServiceFoundCard extends StatelessWidget {
  final ScrollController controller;
  final Function animateToIndex;
  NoServiceFoundCard({
    @required this.controller,
    this.animateToIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 330.0,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Services Found!",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 8.0),
                const Text("Subscribe a Service to get started!"),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 50.0,
                  child: FloatingActionButton(
                    elevation: 2.5,
                    heroTag: 'noservice',
                    onPressed: () {
                      animateToIndex(4.0, controller);
                    },
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 25.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
