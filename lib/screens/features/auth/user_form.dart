import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text("Sign up"),
        centerTitle: true
        ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
              ),

              TextFormField(
                controller: widget.birthDateController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Enter age' : null,
              ),

              const SizedBox(height: 16),

              // _loading
              //     ? const CircularProgressIndicator()
              ////     : DropdownButtonFormField<CatCategory>(
              ////         initialValue: _selectedCategory,
              //         decoration: const InputDecoration(
              ////           labelText: 'Category',
              //           border: OutlineInputBorder(),
              //         ),
              ////         items: _categories.map((category) {
              ////           return DropdownMenuItem<CatCategory>(
              ////             value: category,
              ////             child: Text(category.name),
              //           );
              //         }).toList(),
              //         onChanged: (value) {
              //           setState(() {
              ////             _selectedCategory = value;
              ////             widget.categoryIdController.text =
              ////                 value!.categoryId.toString();
              //           });
              //         },
              //         validator: (value) =>
              ////             value == null ? 'Select a category' : null,
              //       ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: widget.onSubmit,
                child: Text(widget.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
