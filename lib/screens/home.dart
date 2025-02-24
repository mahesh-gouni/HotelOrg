// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:hotelorg/screens/category_page.dart';
import 'package:hotelorg/utilites/qr_code_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.restaurant,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "KOI MANDI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => QRCodeScreen()),
                );
              },
              icon: Icon(Icons.shopping_cart),
              label: Text("Order Now"),
            ),
            SizedBox(height: 20),
      ElevatedButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage()),  // Navigate to CategoryPage
    );
  },
  icon: Icon(Icons.shopping_cart),
  label: Text("Menu Card"),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
