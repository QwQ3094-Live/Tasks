import 'package:flutter/material.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  bool _isSwitched = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
  }
  
  void _showTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Flutter"),
          content: Text("欢迎来到Flutter开发，yeah!!!!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("取消"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("确定"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('你按下按钮这些次了:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Switch is ${_isSwitched ? 'ON' : 'OFF'}'),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Switch(
                      value: _isSwitched,
                      onChanged: _toggleSwitch,
                    ),
                    Switch(
                      value: _isSwitched,
                      onChanged: _toggleSwitch,
                    ),
                    Switch(
                      value: _isSwitched,
                      onChanged: _toggleSwitch,
                    ),
                    Switch(
                      value: _isSwitched,
                      onChanged: _toggleSwitch,
                    ),
                  ],
                ),
              ],
            ),
            FilledButton(
              child: const Text('flutter'),
              onPressed: () {
                _showTestDialog(context);
              },
            ),
            const SizedBox(height: 10),
            FilledButton(
              child: const Text('settings'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
