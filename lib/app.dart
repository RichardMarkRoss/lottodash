import 'pages/loading_page.dart';
import 'package:lottodash/AuthGate.dart';
import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'pages/counter_page.dart';
import 'theme/theme.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _isLoaded = false;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  void _onLoaded() {
    setState(() => _isLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Lotto Dash',
      themeMode: _themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: !_isLoaded
          ? LoadingPage(onLoaded: _onLoaded)
          : AuthGate(onToggleTheme: _toggleTheme),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/counter': (context) => CounterPage(onToggleTheme: _toggleTheme),
      },
    );
  }
}
