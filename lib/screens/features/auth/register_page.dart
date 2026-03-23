import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar((const SnackBar(content: Text("Passwords don't match"))));
      return;
    }
    try {
      await authService.signUpWithPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Sign up")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 24),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm password'),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() => isLoading = true);

                      try {
                        await signUp();
                      } finally {
                        if (mounted) {
                          setState(() => isLoading = false);
                        }
                      }
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign up'),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
