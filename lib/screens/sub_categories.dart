import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hotelorg/screens/items.dart';

class SubCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  SubCategoryPage({required this.categoryId, required this.categoryName});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://e38c-2401-4900-4cef-7df3-9de4-4433-f8ef-cf35.ngrok-free.app/menu'));
  List<Map<String, dynamic>> subCategories = [];
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubCategories(widget.categoryId);
  }

  Future<void> fetchSubCategories(int categoryId) async {
  try {
    final response = await _dio.get(
      '/fetch-subcategories-or-items',
      queryParameters: {'categoryId': categoryId},
    );
    print("API Response: ${response.data}"); // Debugging output

    setState(() {
      subCategories = response.data['subCategories'] != null
          ? List<Map<String, dynamic>>.from(response.data['subCategories'])
          : [];

      items = response.data['items'] != null
          ? List<Map<String, dynamic>>.from(response.data['items'])
          : [];

      isLoading = false; // Set loading to false after data is fetched
    });

    print('Subcategories updated: $subCategories'); // Debugging output
  } catch (e) {
    print('Error fetching subcategories: $e');
    setState(() {
      subCategories = [];
      items = [];
      isLoading = false; // Ensure loading stops even if API fails
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: subCategories.isNotEmpty
    ? GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
        children: subCategories.map((subCategory) => subCategoryCard(subCategory, context)).toList(),
      )
    : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemCard(items[index]);
        },
      ),

            ),
    );
  }

  Widget subCategoryCard(Map<String, dynamic> subCategory, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiryaniMenu(
              categoryId: subCategory['id'],
              categoryName: subCategory['name'],
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            subCategory['name'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget itemCard(Map<String, dynamic> item) {
  bool isVeg = item['type'].toLowerCase() == "veg";

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: Icon(
        Icons.circle,
        color: isVeg ? Colors.green : Colors.red,
      ),
      title: Text(
        item['name'],
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        "₹${item['cost']}.00",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

}
