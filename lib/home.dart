import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Task {
  final String name;
  final String desc;

  const Task({required this.name, required this.desc});

  // 将Task转换为Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desc': desc,
    };
  }

  // 从Map创建Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      desc: map['desc'],
    );
  }
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
  
  @override
  void initState() {
    super.initState();
    _loadTasks(); // 初始化时加载保存的任务
  }

  // 保存任务列表到本地存储
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // 将List<Task>转换为List<Map>然后转为JSON字符串
    final String encodedData = json.encode(
      list.map((task) => task.toMap()).toList(),
    );
    await prefs.setString('tasks', encodedData);
  }

  // 从本地存储加载任务列表
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('tasks');
    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      setState(() {
        list = decodedData.map((item) => Task.fromMap(item)).toList();
      });
    }
  }

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
  
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('删除任务'),
          content: const Text('你确定要删除吗？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  list.clear();
                });
                _saveTasks();
                Navigator.of(context).pop();
              },
              child: Text(
                '确定',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onConfirm({required String name, required String desc}) {
    if (name.isEmpty) return; // 简单验证
    
    final Task t = Task(name: name, desc: desc);
    setState(() {
      list.add(t);
    });
    _saveTasks(); // 每次添加后保存
  }

  // 删除任务
  void _deleteTask(int index) {
    setState(() {
      list.removeAt(index);
    });
    _saveTasks(); // 删除后保存
  }

  List<Widget> _getTiles() {
    return List<Widget>.generate(list.length, (index) {
      final task = list[index];
      return Dismissible(
        key: Key('$index-${task.name}'), // 唯一key
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) => _deleteTask(index),
        child: ListTile(
          title: Text(task.name),
          subtitle: Text(task.desc),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('任务列表'),
        actions: [
          if (list.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                 _showDeleteDialog();
              },
              tooltip: '清空所有',
            )
        ],
      ),
      body: list.isEmpty
          ? const Center(child: Text('暂无任务，点击右下角添加'))
          : ListView(children: _getTiles()),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTaskDialog,
        tooltip: '添加任务',
        child: const Icon(Icons.add),
      ),
    );
  }
}