import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';
import 'package:supa_routines/screens/features/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await authService.signInWithEmailPassword(email, password);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 24,),

            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email'),),
            const SizedBox(height: 24,),
        
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'),),
        
            const SizedBox(height: 24,),
        
            ElevatedButton(onPressed: login, child:  const Text("Login")),
        
            const SizedBox(height: 24,),
        
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              ),
              child: Center(child: Text("Don't have an accout?")),
            ),
          ],
        ),
      ),
    );
  }
}
