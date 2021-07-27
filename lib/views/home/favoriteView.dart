import 'package:adam/widgets/serviceCard.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  final List<ServiceCard> favoriteServices;

  const FavoriteView({Key key, this.favoriteServices}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: favoriteServices.length,
        itemBuilder: (context, index) {
          if (favoriteServices.length == 0) {
            return Center(
              child: Text("No Favorite Services!"),
            );
          }
          return favoriteServices[index];
        },
      ),
    );
  }
}
