import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BiryaniMenu extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const BiryaniMenu({super.key, required this.categoryId, required this.categoryName});
  
  @override
  _BiryaniMenuState createState() => _BiryaniMenuState();
}

class _BiryaniMenuState extends State<BiryaniMenu> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://e38c-2401-4900-4cef-7df3-9de4-4433-f8ef-cf35.ngrok-free.app/menu'));
  bool showVeg = true;
  bool showNonVeg = true;
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubCategoryItems(widget.categoryId);
  }

  Future<void> fetchSubCategoryItems(int subCategoryId) async {
  try {
    final response = await _dio.get('/items/by-subcategory', queryParameters: {'subCategoryId': subCategoryId});
    
    print("API Response: ${response.data}"); // Debugging output
    
    setState(() {
      items = List<Map<String, dynamic>>.from(response.data);
      isLoading = false;
    });

    print("Items List Updated: $items"); // Debugging output

  } catch (e) {
    print("Error fetching items: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.redAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterChip(
                        label: Text("Veg"),
                        selected: showVeg,
                        onSelected: (bool value) {
                          setState(() {
                            showVeg = value;
                          });
                        },
                        selectedColor: Colors.green.withOpacity(0.5),
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text("Non-Veg"),
                        selected: showNonVeg,
                        onSelected: (bool value) {
                          setState(() {
                            showNonVeg = value;
                          });
                        },
                        selectedColor: Colors.red.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      bool isVeg = item['type'].toLowerCase() == "veg";
                      if ((isVeg && showVeg) || (!isVeg && showNonVeg)) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            leading: Icon(
                              Icons.circle,
                              color: isVeg ? Colors.green : Colors.red,
                            ),
                            title: Text(item['name']),
                            trailing: Text("₹${item['cost']}.00"),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
