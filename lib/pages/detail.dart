import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题 $item'),
      ),
      body: Center(
        child: Text('这是第 $item 个 listTile'),
      ),
    );
  }
}
