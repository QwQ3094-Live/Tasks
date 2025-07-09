import 'package:flutter/material.dart';
import 'detail.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  bool _isSwitched = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
  }

  void onTapTile(int i) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: i),
      ),
    );
  }

  List<Widget> _getTiles() {
    List<Widget> list = [];
    for (var i = 1; i < 21; i++) {
      list.add(ListTile(
        leading: Icon(Icons.reply),
        title: Text('标题$i'),
        subtitle: Text('这是第$i个ListTile'),
        onTap: () => onTapTile(i),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getTiles(),
    );
  }
}
