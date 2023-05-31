import "package:flutter/material.dart";
import "package:matching/representation/widgets/mini_app_bar_container.dart";

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  static const String routeName = "/delivery";

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final emailRegex = RegExp(
      r"^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$");
  final phoneRegex = RegExp(
      r"^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$");
  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform desired actions
      String name = _nameController.text;
      String address = _addressController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      // Clear the form fields
      _nameController.clear();
      _addressController.clear();
      _emailController.clear();
      _phoneController.clear();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: "Delivery Address",
      implementLeading: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!emailRegex.hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone number"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  } else if (!phoneRegex.hasMatch(value)) {
                    return "Please enter a valid phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
