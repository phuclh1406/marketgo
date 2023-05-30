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
  final List<String> listStep = [
    "Delivery",
    "Payment",
    "Confirm",
  ];

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

  Widget _buildItemStepCheckout(
      int step, String stepName, bool isEnd, bool isCheck) {
    return Row(
      children: [
        Container(
          width: kMediumPadding,
          height: kMediumPadding,
          decoration: BoxDecoration(
            color: isCheck
                ? ColorPalette.yellowColor
                : ColorPalette.yellowColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(
              kMediumPadding,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: kMinPadding,
        ),
        Text(
          stepName,
          style: const TextStyle(
              color: ColorPalette.yellowColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: kMinPadding,
        ),
        if (!isEnd)
          const SizedBox(
            width: kDefaultPadding,
            child: Divider(
              height: 1,
              thickness: 1,
              color: ColorPalette.yellowColor,
            ),
          ),
        if (!isEnd)
          const SizedBox(
            width: kMinPadding,
          ),
      ],
    );
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
      titleString: "Delivery Address",
      implementLeading: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listStep
                  .map((e) => _buildItemStepCheckout(
                        listStep.indexOf(e) + 1,
                        e,
                        listStep.indexOf(e) == listStep.length - 1,
                        listStep.indexOf(e) == 0,
                      ))
                  .toList(),
            ),
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
                    "Delivery info",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
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
                                const InputDecoration(labelText: "Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: "Email"),
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
                            decoration: const InputDecoration(
                                labelText: "Phone number"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your phone number";
                              } else if (!phoneRegex.hasMatch(value)) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration:
                                const InputDecoration(labelText: "Address"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please choose a city";
                              }
                              return null;
                            },
                            value: selectedValue,
                            items: [
                              const DropdownMenuItem<String>(
                                value: "",
                                enabled: false,
                                child: Text('Select a city'),
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
                              labelText: 'City',
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ButtonWidget(
                            title: "Submit",
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
