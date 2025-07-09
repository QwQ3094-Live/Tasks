import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  String _select = 'male';
  bool _isChecked = false;
  final List<String> data = ['语文', '数学', '英语', '物理', '化学', '生物', '地理'];
  late String _dropdownValue = data.first;

  void _selectRadio(String? value) {
    setState(() {
      _select = value!;
    });
  }

  void _toggleChecked(bool? checked) {
    setState(() {
      _isChecked = checked!;
    });
  }
  
  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text)
      ),
    );
  }

  void _showFieldDialog(BuildContext context, void Function(String) onConfirm) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog'),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Text',
            ),
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                onConfirm(controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Sure"),
            ),
          ],
        );
      },
    );
  }

  void _onSelect(String? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }

  List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
          child: const Text('Select your gender.'),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'male',
            groupValue: _select,
            onChanged: _selectRadio,
          ),
          title: const Text('male'),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'female',
            groupValue: _select,
            onChanged: _selectRadio,
          ),
          title: const Text('female'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
          child: Text('Your gender is $_select'),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
          child: const Text('Checkbox tile'),
        ),

        ListTile(
          leading: Checkbox(
            value: _isChecked,
            onChanged: _toggleChecked,
          ),
          title: const Text('test'),
        ),

        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Text field'),

              const SizedBox(height: 15),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text',
                ),
              ),

              const SizedBox(height: 15),

              FilledButton(
                child: const Text('dialog'),
                onPressed: () {
                  _showFieldDialog(
                    context,
                    (text) {
                      _showSnackBar(text);
                    },
                  );
                }
              ),

              const SizedBox(height: 15),

              DropdownMenu<String>(
                menuHeight: 200,
                initialSelection: data.first,
                onSelected: _onSelect,
                dropdownMenuEntries: _buildMenuList(data),
              ),
              const SizedBox(height: 8),
              Text('你选择的学科是: $_dropdownValue')
            ],
          ),
        ),
      ],
    );
  }
}
