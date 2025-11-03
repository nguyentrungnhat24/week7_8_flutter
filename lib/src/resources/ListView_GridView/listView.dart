import 'package:flutter/material.dart';

class DemoListView extends StatefulWidget {
  const DemoListView({super.key});

  @override
  State<DemoListView> createState() => _DemoListViewState();
}

class _DemoListViewState extends State<DemoListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 50,
            color: Colors.red,
            child: const Center(child: Text("Hello")),
          ),
          Container(
            height: 50,
            color: Colors.green,
            child: const Center(child: Text("Hello 2 ")),
          ),
          Container(
            height: 50,
            color: Colors.blue,
            child: const Center(child: Text("Hello 3")),
          ),
        ],
      ),
    );
  }
}
