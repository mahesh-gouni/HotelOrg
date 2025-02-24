// // lib/screens/items.dart

// import 'package:flutter/material.dart';
// import 'package:hotelorg/models/menu_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BiryaniMenu extends StatefulWidget {
//   @override
//   _BiryaniMenuState createState() => _BiryaniMenuState();
// }

// class _BiryaniMenuState extends State<BiryaniMenu> {
//   late Future<List<MenuCategory>> futureMenu;

//   @override
//   void initState() {
//     super.initState();
//     futureMenu = fetchMenuData();
//   }

//   Future<List<MenuCategory>> fetchMenuData() async {
//     final url = Uri.parse("https://cb82-2401-4900-4cef-7df3-f9b3-a23-8df3-bb07.ngrok-free.app/menu/fetch-categories");

//     try {
//       print("Fetching data from API...");
//       final response = await http.get(url, headers: {"Accept": "application/json"});

//       print("Response Status Code: ${response.statusCode}");

//       if (response.statusCode != 200) {
//         throw Exception("API Error: ${response.statusCode}");
//       }

//       if (response.body.startsWith("<!DOCTYPE html>") || response.body.startsWith("<html>")) {
//         print("⚠️ API returned HTML instead of JSON:\n${response.body}");
//         throw Exception("Invalid JSON Response: API returned HTML.");
//       }

//       final List<dynamic> jsonData = jsonDecode(response.body);
//       return jsonData.map((cat) => MenuCategory.fromJson(cat)).toList();
//     } catch (e) {
//       print("Error fetching data: $e");
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Biryani Menu"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: FutureBuilder<List<MenuCategory>>(
//         future: futureMenu,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Error loading menu!", style: TextStyle(color: Colors.red, fontSize: 18)),
//                   SizedBox(height: 10),
//                   Text(snapshot.error.toString(), textAlign: TextAlign.center),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No menu data available."));
//           }

//           final menuCategories = snapshot.data!;

//           return ListView.builder(
//             itemCount: menuCategories.length,
//             itemBuilder: (context, index) {
//               final category = menuCategories[index];
//               return ExpansionTile(
//                 title: Text(category.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 children: category.subCategories.map((subCat) {
//                   return ExpansionTile(
//                     title: Text(subCat.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     children: subCat.items.map((item) {
//                       return ListTile(
//                         leading: Icon(Icons.circle, color: item.type == "veg" ? Colors.green : Colors.red),
//                         title: Text(item.name),
//                         trailing: Text(
//                           item.inStock ? "₹${item.cost}" : "Out of Stock",
//                           style: TextStyle(color: item.inStock ? Colors.black : Colors.red),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 }).toList(),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
