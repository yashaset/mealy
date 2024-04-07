import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsDetailsScreen extends StatelessWidget {
  const MealsDetailsScreen(
      {required this.imageUrl, required this.title, super.key});
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals Detail"),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }
}
