import 'package:fl_week01/src/resources/signIn.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _showHeart = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 270,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 238, 238),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset("assets/images/AppleProductdetail.png"),
                  ),
                  Positioned(
                    top: 10, // Khoảng cách từ trên
                    left: 16, // Khoảng cách từ trái
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background cho icon
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () {
                          // Ve LoginPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        color: Colors.black,
                        constraints: BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10, // Khoảng cách từ trên
                    right: 16, // Khoảng cách từ trái
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background cho icon
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: IconButton(
                        icon: Icon(Icons.upload),
                        onPressed: () {
                          // Ve LoginPage
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LoginPage()),
                          // );
                        },
                        color: Colors.black,
                        constraints: BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Naturel Red Apple",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggleShowHeart,
                      child: Icon(
                        _showHeart ? Icons.favorite : Icons.favorite_border,
                        color: _showHeart ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Text(
                  "1kg, Price",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          color: _quantity > 1 ? Colors.green : Colors.grey,
                          onPressed: onPressRemove,
                          constraints: BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            _quantity.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          color: _quantity < 5 ? Colors.green : Colors.grey,
                          iconSize: 26,
                          onPressed: onPressAdd,
                        ),
                      ],
                    ),
                    Text(
                      "\$4.99",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Divider(color: Colors.grey, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Detail",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Text(
                  "Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Divider(color: Colors.grey, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nutritions",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text("100g"),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Divider(color: Colors.grey, thickness: 2),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nutritions",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // 👈 màu nền
                      foregroundColor: Colors.black, // 👈 màu chữ (text/icon)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onPressed: onPressAddToBasket,
                    child: Text(
                      "Add To Batket",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowHeart() {
    setState(() {
      _showHeart = !_showHeart;
    });
  }

  void onPressRemove() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void onPressAdd() {
    setState(() {
      if (_quantity < 5) {
        _quantity++;
      }
    });
  }

  void onPressAddToBasket() {}
}
