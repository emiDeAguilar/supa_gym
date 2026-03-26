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
    const List<String> genders = <String>['Male', 'Female', 'Don\'t specify'];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'CREATE AN ACCOUNT',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'USERNAME',
                style: TextStyle(
                  fontSize: AppTextStyles.mediumFont,
                  letterSpacing: 2,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: widget.usernameController,
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
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter username' : null,
              ),

              const SizedBox(height: 20),

              const Text(
                'BIRTH DATE',
                style: TextStyle(
                  fontSize: AppTextStyles.mediumFont,
                  letterSpacing: 2,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 4),

              TextFormField(
                controller: widget.birthDateController,
                readOnly: true,
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
                  hintText: 'YYYY-MM-DD',
                ),

                onTap: _pickDate,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Select birth date' : null,
              ),

              const SizedBox(height: 20),
              const Text(
                'GENDER',
                style: TextStyle(
                  fontSize: AppTextStyles.mediumFont,
                  letterSpacing: 2,
                  color: Color(0xFF999999),
                ),
              ),
              const SizedBox(height: 4),
              DropdownMenu<String>(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF1A1A1A),
                ),
                initialSelection: widget.genderController.text.isNotEmpty
                    ? widget.genderController.text
                    : null,
                onSelected: (String? value) {
                  if (value != null) {
                    widget.genderController.text = value;
                  }
                },
                dropdownMenuEntries: genders
                    .map<DropdownMenuEntry<String>>(
                      (String value) =>
                          DropdownMenuEntry<String>(value: value, label: value),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.buttonText,
                        style: TextStyle(
                          letterSpacing: 3,
                          fontSize: AppTextStyles.mediumFont,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
