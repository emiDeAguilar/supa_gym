import 'package:flutter/material.dart';
import 'package:supa_routines/main.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';
import 'package:supa_routines/widgets/gym_logo.dart';
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
    await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> addPersonalInfo(String userId, String email) async {
    final values = {'id_usuario': userId, 'correo': email, 'activo': true};
    try {
      await supabase.from('users').insert(values);
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
    Color bg = Theme.of(context).colorScheme.primaryContainer;
    Color text = Theme.of(context).colorScheme.onPrimaryContainer;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        iconTheme: IconThemeData(color: text),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: const GymLogo(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Sign Up.',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: Color(0xFF0D0D0D),
                height: 1.1,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'EMAIL',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D0D0D)),
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'PASSWORD',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D0D0D)),
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              obscureText: true,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'CONFIRM PASSWORD',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D0D0D)),
                ),
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 8),
              ),
              obscureText: true,

              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Color(0xFF1A1A1A),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D0D0D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SIGN UP',
                            style: TextStyle(letterSpacing: 3, fontSize: 12),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
