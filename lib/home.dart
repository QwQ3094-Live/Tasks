import 'package:flutter/material.dart';

class Task {
  final String name;
  final String desc;

  const Task({required this.name, required this.desc});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  List<Task> list = [];

  void _showTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('添加你的任务'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '名字',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '内容',
                ),
                controller: descController,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                _onConfirm(name: nameController.text, desc: descController.text);
                nameController.clear();
                descController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _onConfirm({required String name, required String desc}) {
    final Task t = Task(name: name, desc: desc);
    setState(() {
      list.add(t);
    });
  }

  List<Widget> _getTiles() {
    List<Widget> tiles = [];
    for (var i = 0; i < list.length; i++) {
      Task it = list[i];
      tiles.add(ListTile(
        title: Text(it.name),
        subtitle: Text(it.desc),
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: _getTiles(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTaskDialog,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}