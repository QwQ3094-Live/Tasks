import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _useMaterial3 = true;
  String _brightness = '跟随系统';
  double _round = 20;
  String _date = '';

  void _toggleMaterial3(bool value) {
    setState(() {
      _useMaterial3 = value;
    });
  }
  
  void _toggleTheme(String value) {
    setState(() {
      _brightness = value;
    });
  }
  
  void _changeRound(double value) {
    setState(() {
      _round = value;
    });
  }
  
  void _inputDate(String? value) {
    setState(() {
      if (value != null) _date = value;
      else _date = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          PreferenceTitle(text: '主题'),
          
          SwitchPreference(
            iconData: Icons.filter_3,
            title: '使用Material 3',
            subtitle: '选择是否材料设计3',
            isChecked: _useMaterial3,
            onChecked: _toggleMaterial3,
          ),
          MenuPreference(
            iconData: Icons.brightness_4,
            title: '主题模式',
            subtitle: _brightness,
            menuItems: [
              MenuItemButton(
                child: const Text('跟随系统'),
                onPressed: () => _toggleTheme('跟随系统'),
              ),
              MenuItemButton(
                child: const Text('明亮'),
                onPressed: () => _toggleTheme('明亮'),
              ),
              MenuItemButton(
                child: const Text('黑暗'),
                onPressed: () => _toggleTheme('黑暗'),
              ),
              MenuItemButton(
                child: const Text('OLED纯黑'),
                onPressed: () => _toggleTheme('OLED纯黑'),
              ),
            ],
          ),
          
          PreferenceTitle(text: '通用'),
          
          SliderPreference(
            iconData: Icons.rounded_corner,
            title: '圆角大小',
            slider: Slider(
              value: _round,
              max: 24,
              label: _round.toString(),
              onChanged: (double value) => _changeRound(value),
            ),
          ),
          
          EditTextPreference(
            iconData: Icons.date_range,
            title: '日期输入',
            subtitle: '$_date',
            dialogTitle: '输入你的日期',
            dialogContent: '日期',
            dialogCancel: '取消',
            dialogSure: '确定',
            onConfirm: (String date) => _inputDate(date),
          ),
        ],
      ),
    );
  }
}

class PreferenceTitle extends StatelessWidget {
  const PreferenceTitle({
    super.key,
    required this.text
  });
  
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      )
    );
  }
}

class SwitchPreference extends StatefulWidget {
  SwitchPreference({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChecked,
  });

  final IconData iconData;
  final String title;
  final String subtitle;
  final bool isChecked;
  final void Function(bool) onChecked;

  @override
  State<SwitchPreference> createState() => _SwitchPreferenceState();
}

class _SwitchPreferenceState extends State<SwitchPreference> {
  IconData get iconData => widget.iconData;
  String get title => widget.title;
  String get subtitle => widget.subtitle;
  bool get isChecked => widget.isChecked;
  Function(bool) get onChecked => widget.onChecked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: isChecked,
        onChanged: onChecked,
      ),
    );
  }
}

class MenuPreference extends StatefulWidget {
  MenuPreference({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.menuItems,
  });
  
  final IconData iconData;
  final String title;
  final String subtitle;
  final List<Widget> menuItems;
  
  @override
  State<MenuPreference> createState() => _MenuPreferenceState();
}

class _MenuPreferenceState extends State<MenuPreference> {
  IconData get iconData => widget.iconData;
  String get title => widget.title;
  String get subtitle => widget.subtitle;
  List<Widget> get menuItems => widget.menuItems;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return ListTile(
          leading: Icon(iconData),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          }
        );
      },
      menuChildren: menuItems,
    );
  }
}

class SliderPreference extends StatefulWidget {
  SliderPreference({
    super.key,
    required this.iconData,
    required this.title,
    required this.slider,
  });
  
  final IconData iconData;
  final String title;
  final Widget slider;
  
  @override
  State<SliderPreference> createState() => _SliderPreferenceState();
}

class _SliderPreferenceState extends State<SliderPreference> {
  IconData get iconData => widget.iconData;
  String get title => widget.title;
  Widget get slider => widget.slider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      subtitle: slider,
    );
  }
}

class EditTextPreference extends StatefulWidget {
  EditTextPreference({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.dialogTitle,
    required this.dialogContent,
    required this.dialogCancel,
    required this.dialogSure,
    required this.onConfirm,
  });
  
  final IconData iconData;
  final String title;
  final String subtitle;
  final String dialogTitle;
  final String dialogContent;
  final String dialogCancel;
  final String dialogSure;
  final void Function(String) onConfirm;
  
  @override
  State<EditTextPreference> createState() => _EditTextPreferenceState();
}

class _EditTextPreferenceState extends State<EditTextPreference> {
  IconData get iconData => widget.iconData;
  String get title => widget.title;
  String get subtitle => widget.subtitle;
  String get dialogTitle => widget.dialogTitle;
  String get dialogContent => widget.dialogContent;
  String get dialogCancel => widget.dialogCancel;
  String get dialogSure => widget.dialogSure;
  Function(String) get onConfirm => widget.onConfirm;
  
  void showEditTextDialog(BuildContext context) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: dialogContent,
            ),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(dialogCancel),
            ),
            FilledButton(
              onPressed: () {
                onConfirm(controller.text);
                Navigator.of(context).pop();
              },
              child: Text(dialogSure),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => showEditTextDialog(context),
    );
  }
}
