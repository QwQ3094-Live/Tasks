import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components.dart';
import 'main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _brightness = '跟随系统';
  double _round = 20;
  String _date = '';
  
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
    final appState = Provider.of<AppState>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const PreferenceTitle(text: '主题'),
          
          SwitchPreference(
            iconData: Icons.filter_3,
            title: '使用Material 3',
            subtitle: '选择是否材料设计3',
            isChecked: appState.useMaterial3,
            onChecked: (value) => appState.useMaterial3 = value,
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
          
          const PreferenceTitle(text: '通用'),
          
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
            subtitle: _date,
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