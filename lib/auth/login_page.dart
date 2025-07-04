import 'package:firebase_auth/firebase_auth.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  Future<void> _login() async {
    setState(() => _error = null);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/counter');
    } catch (e) {
      String msg = "Email or password incorrect.";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          msg = "No account found for that email.";
        } else if (e.code == 'wrong-password') {
          msg = "Incorrect password.";
        } else {
          msg = e.message ?? msg;
        }
      }
      setState(() => _error = msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: Card(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                placeholder: Text('Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                placeholder: Text('Password'),
                obscureText: true,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              PrimaryButton(onPressed: _login, child: const Text('Login')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
