import 'package:flutter/material.dart';

class BiryaniMenu extends StatefulWidget {
  @override
  _BiryaniMenuState createState() => _BiryaniMenuState();
}

class _BiryaniMenuState extends State<BiryaniMenu> {
  bool showVeg = true;
  bool showNonVeg = true;

  final List<Map<String, dynamic>> menuItems = [
    {"name": "Veg Biryani", "price": 140, "veg": true},
    {"name": "Paneer Biryani", "price": 160, "veg": true},
    {"name": "Paneer Tikka Biryani", "price": 170, "veg": true},
    {"name": "Chicken Fry Biryani", "price": 190, "veg": false},
    {"name": "Chicken Dum Biryani", "price": 170, "veg": false},
    {"name": "Chicken Lollipop Biryani", "price": 200, "veg": false},
    {"name": "Spl Chicken Biryani", "price": 210, "veg": false},
    {"name": "Naatu Kodi Biryani", "price": 240, "veg": true},
    {"name": "Chitti Mutyala Pulao", "price": 0, "veg": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biryani Menu"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
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
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                if ((item['veg'] && showVeg) || (!item['veg'] && showNonVeg)) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: item['veg'] ? Colors.green : Colors.red,
                      ),
                      title: Text(item['name']),
                      trailing: Text("₹${item['price']}.00"),
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
