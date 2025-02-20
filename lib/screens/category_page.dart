import 'package:flutter/material.dart';

import 'package:hotelorg/screens/items.dart';  // Import the BiryaniMenu file

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AG SPORTS - DESI DHABA"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
          children: [
            categoryCard("Veg Soups", context),
            categoryCard("Non-veg Soups", context),
            categoryCard("Veg Starters", context),
            categoryCard("Egg Starters", context),
            categoryCard("Non-veg Starters", context),
          ],
        ),
      ),
    );
  }

  Widget categoryCard(String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Veg Soups") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BiryaniMenu()), // Navigate to BiryaniMenu
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
