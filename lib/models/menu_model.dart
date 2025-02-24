// // lib/models/menu_model.dart

// class MenuCategory {
//   final int id;
//   final String name;
//   final List<SubCategory> subCategories;

//   MenuCategory({required this.id, required this.name, required this.subCategories});

//   factory MenuCategory.fromJson(Map<String, dynamic> json) {
//     return MenuCategory(
//       id: json['id'],
//       name: json['name'],
//       subCategories: (json['subCategories'] as List)
//           .map((subCat) => SubCategory.fromJson(subCat))
//           .toList(),
//     );
//   }
// }

// class SubCategory {
//   final int id;
//   final String name;
//   final List<MenuItem> items;

//   SubCategory({required this.id, required this.name, required this.items});

//   factory SubCategory.fromJson(Map<String, dynamic> json) {
//     return SubCategory(
//       id: json['id'],
//       name: json['name'],
//       items: (json['items'] as List).map((item) => MenuItem.fromJson(item)).toList(),
//     );
//   }
// }

// class MenuItem {
//   final int id;
//   final String name;
//   final double cost;
//   final String type;
//   final bool inStock;

//   MenuItem({required this.id, required this.name, required this.cost, required this.type, required this.inStock});

//   factory MenuItem.fromJson(Map<String, dynamic> json) {
//     return MenuItem(
//       id: json['id'],
//       name: json['name'],
//       cost: json['cost'].toDouble(),
//       type: json['type'],
//       inStock: json['inStock'],
//     );
//   }
// }
