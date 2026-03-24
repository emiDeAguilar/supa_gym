import 'package:flutter/material.dart';


class AgregarRutina extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  //final TextEditingController categoryIdController;
  final String buttonText;
  final VoidCallback onSubmit;

  const AgregarRutina({
    super.key,
    required this.title,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    //required this.categoryIdController,
    required this.buttonText,
    required this.onSubmit,
  });

  @override
  State<AgregarRutina> createState() => _AgregarRutinaState();
}

class _AgregarRutinaState extends State<AgregarRutina> {
  
  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter name' : null,
              ),

              TextFormField(
                controller: widget.priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter price' : null,
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
