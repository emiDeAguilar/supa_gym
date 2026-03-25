import 'package:flutter/material.dart';
import 'package:supa_routines/widgets/user_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  AddUserPageState createState() => AddUserPageState();
}

class AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();

  // Guardar nuevo usuario (equivalente a saveProduct)
  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final birthDate = _birthDateController.text.trim();
      final gender = _genderController.text.trim();

      final user = Supabase.instance.client.auth.currentUser;

      final existing = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', user!.id)
          .maybeSingle();

      if (existing == null) {
        await Supabase.instance.client.from('users').insert({
          'id': user.id,
          'email': user.email,
          'username': username,
          'birth_date': birthDate,
          'gender': gender,
        });
      } else {
        await Supabase.instance.client
            .from('users')
            .update({
              'username': username,
              'birth_date': birthDate,
              'gender': gender,
            })
            .eq('id', user.id);

        if (!mounted) return;
        Navigator.pop(context, 'added');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserForm(
      title: 'Sign in',
      formKey: _formKey,
      usernameController: _usernameController,
      birthDateController: _birthDateController,
      genderController: _genderController,
      buttonText: 'Continue',
      onSubmit: _saveUser,
    );
  }
}
