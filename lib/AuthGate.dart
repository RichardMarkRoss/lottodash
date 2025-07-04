import 'package:firebase_auth/firebase_auth.dart';
import 'pages/counter_page.dart';
import 'auth/login_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AuthGate extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const AuthGate({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return CounterPage(onToggleTheme: onToggleTheme);
        }
        return const LoginPage();
      },
    );
  }
}
