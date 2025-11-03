import 'package:fl_week01/src/resources/home_screen.dart';
import 'package:flutter/material.dart';
import '../resources/cart_screen.dart';
import '../resources/explore_screen.dart';
import '../resources/favourite_screen.dart';
import '../resources/account_screen.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  static final List<Map<String, dynamic>> items = [
    {
      "icon": Icons.storefront,
      "label": "Shop",
      "widget": HomePage(), // trang khi bấm vào
    },
    {"icon": Icons.search, "label": "Explore", "widget": ExplorePage()},
    {"icon": Icons.shopping_cart, "label": "Cart", "widget": CartPage()},
    {
      "icon": Icons.favorite_border,
      "label": "Favourite",
      "widget": FavouritePage(),
    },
    {"icon": Icons.person_outline, "label": "Account", "widget": AccountPage()},
  ];

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(myWidth * 0.04),
          topRight: Radius.circular(myWidth * 0.04),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: myHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () {
              onTap(index);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item["widget"]),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item["icon"],
                  color: isSelected ? Colors.green : Colors.black87,
                  size: myWidth * 0.07,
                ),
                SizedBox(height: myHeight * 0.005),
                Text(
                  item["label"],
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: myWidth * 0.035,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
