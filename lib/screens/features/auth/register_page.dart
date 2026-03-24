import 'package:flutter/material.dart';
import 'package:supa_routines/main.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    // try {
      // final response = await authService.signUpWithPassword(email, password);
      await supabase.auth.signUp(email:email, password:  password);

    //   final userId = response.user?.id;
    //   if (userId == null) {
    //     throw Exception("User not returned after signup");
    //   }
      
    //   // await createProfile(userId, email);
    // } catch (e) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(
    //       context,
    //     ).showSnackBar(SnackBar(content: Text("Error: $e")));
    //   }
    // }
  }

  Future<void> createProfile(String userId, String email) async {
    final values = {'id_usuario': userId, 'correo': email, 'activo': true};
    try {
      await supabase.from('Usuario_usuarios').insert(values);
    } on PostgrestException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message), backgroundColor: Colors.red),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Unexpected error."),
            backgroundColor: Colors.red,
          ),
        );
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
