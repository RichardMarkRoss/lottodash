import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreedToTerms = false;
  String? _error;
  bool _showingDialog = false;

  Future<void> _register() async {
    setState(() => _error = null);
    if (_passwordController.text != _confirmController.text) {
      setState(() => _error = "Passwords do not match.");
      return;
    }
    if (!_agreedToTerms) {
      setState(() => _error = "You must agree to Terms & Privacy Policy.");
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/counter');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  void _showPolicyDialog() {
    if (_showingDialog) return;
    setState(() => _showingDialog = true);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terms & Conditions / Privacy Policy"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "By registering, you agree to our Terms and Conditions and Privacy Policy. "
                "You can customize this dialog with your real policy text or provide links below.",
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // You can use url_launcher to open a link if desired
                    },
                    child: const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Color(0xFF1E88E5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // You can use url_launcher to open a link if desired
                    },
                    child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: Color(0xFF1E88E5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          PrimaryButton(
            child: const Text("Close"),
            onPressed: () {
              setState(() => _showingDialog = false);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ).then((_) => setState(() => _showingDialog = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: Container(
          width: 400,
          child: Card(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Register',
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
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmController,
                  placeholder: Text('Confirm Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      state: _agreedToTerms
                          ? CheckboxState.checked
                          : CheckboxState.unchecked,
                      onChanged: (checked) {
                        setState(() {
                          _agreedToTerms = checked == CheckboxState.checked;
                        });
                      },
                      trailing: const Text('Agree'),
                    ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(text: "I agree to the "),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: const TextStyle(
                                color: Color(0xFF1E88E5),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _showPolicyDialog,
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: const TextStyle(
                                color: Color(0xFF1E88E5),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _showPolicyDialog,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                PrimaryButton(
                  onPressed: _agreedToTerms ? _register : null,
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
