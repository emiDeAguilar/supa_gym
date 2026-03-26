import 'package:flutter/material.dart';
import 'package:supa_routines/styles/app_text_styles.dart';
class UserForm extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController birthDateController;
  final TextEditingController genderController;
  final String buttonText;
  final VoidCallback onSubmit;

  const UserForm({
    super.key,
    required this.title,
    required this.formKey,
    required this.usernameController,
    required this.birthDateController,
    required this.genderController,
    required this.buttonText,
    required this.onSubmit,
  });

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      widget.birthDateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void _handleSubmit() {
    if (widget.formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter username' : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: widget.birthDateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Birth date',
                  hintText: 'YYYY-MM-DD',
                ),
                onTap: _pickDate,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Select birth date' : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: widget.genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter gender' : null,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(widget.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}