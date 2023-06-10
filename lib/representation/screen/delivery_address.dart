import "package:flutter/material.dart";
import "package:matching/data/model/delivery_form.dart";
import "package:matching/representation/screen/check_out_screen.dart";
import "package:matching/representation/widgets/button_widget.dart";
import "package:matching/representation/widgets/mini_app_bar_container.dart";

import "../../core/constants/color_constants.dart";
import "../../core/constants/dismension_constants.dart";

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
  final AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final emailRegex = RegExp(
      r"^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$");
  final phoneRegex = RegExp(
      r"^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$");

  String? selectedValue;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String address = _addressController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String city = selectedValue!;

      Navigator.pushNamed(
        context,
        CheckOutScreen.routeName,
        arguments: DeliveryForm(
            name: name,
            email: email,
            phone: phone,
            address: address,
            city: city),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listCity = [
      "Hồ Chí Minh",
      "Đà Nẵng",
      "Vũng tàu",
      "Nha Trang",
      "Hà Tĩnh"
    ];

    return MiniAppBarContainerWidget(
      titleString: "Địa chỉ giao hàng",
      implementLeading: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Địa chỉ cá nhân",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidateMode,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: "Họ và Tên"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng điền tên của bạn";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: "Địa chỉ Email"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng điền địa chỉ email của bạn";
                              } else if (!emailRegex.hasMatch(value)) {
                                return "Địa chỉ email không hợp lệ";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                                labelText: "Số điện thoại"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng điền số điện thoại của bạn";
                              } else if (!phoneRegex.hasMatch(value)) {
                                return "Số điện thoại không hợp lệ";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration:
                                const InputDecoration(labelText: "Địa chỉ"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng điền địa chỉ của bạn";
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Chọn thành phố";
                              }
                              return null;
                            },
                            value: selectedValue,
                            items: [
                              const DropdownMenuItem<String>(
                                value: "",
                                enabled: false,
                                child: Text('Chọn thành phố'),
                              ),
                              ...listCity.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Thành phố',
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ButtonWidget(
                            title: "Tiếp tục",
                            ontap: () {
                              _submitForm();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
