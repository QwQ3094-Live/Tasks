import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'settings.dart';

void main() {
  runApp(const App());
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
}

// 全局状态管理
class AppState extends ChangeNotifier {
  bool _useMaterial3 = true;
  
  bool get useMaterial3 => _useMaterial3;
  
  set useMaterial3(bool value) {
    _useMaterial3 = value;
    notifyListeners();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const AppContent(),
    );
  }
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightColorScheme = lightDynamic ?? ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        );
        final darkColorScheme = darkDynamic ?? ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        );

        return MaterialApp(
          title: 'Tasks',
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: appState.useMaterial3,
            sliderTheme: const SliderThemeData(year2023: false),
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: appState.useMaterial3,
            sliderTheme: const SliderThemeData(year2023: false),
          ),
          themeMode: ThemeMode.system,
          home: const Main(title: 'Tasks'),
        );
      },
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});

  final String title;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SettingScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}