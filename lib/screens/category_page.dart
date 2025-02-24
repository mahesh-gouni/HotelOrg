import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hotelorg/screens/items.dart';
import 'package:hotelorg/screens/sub_categories.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://d35b-2401-4900-4cef-727e-7d30-2a38-c3ff-5320.ngrok-free.app/menu'));
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await _dio.get('/fetch-categories-names');
      setState(() {
        categories = List<Map<String, dynamic>>.from(response.data);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching categories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KOI MANDI"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                children: categories
                    .map((category) => categoryCard(category, context))
                    .toList(),
              ),
            ),
    );
  }

  Widget categoryCard(Map<String, dynamic> category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryPage(
              categoryId: category['id'],
              categoryName: category['name'],
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            category['name'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
