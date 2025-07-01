import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'pages/counter_page.dart';
import 'theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'My App',
      themeMode: _themeMode,
      home: CounterPage(onToggleTheme: _toggleTheme),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
