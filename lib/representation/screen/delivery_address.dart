import "package:flutter/material.dart";
import "package:matching/model/city_model.dart";
import 'package:matching/model/delivery_form.dart';
import "package:matching/representation/screen/check_out_screen.dart";
import "package:matching/representation/widgets/button_widget.dart";
import "package:matching/representation/widgets/mini_app_bar_container.dart";
import "package:matching/services/city_service.dart";

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
  final TextEditingController _phoneController = TextEditingController();
  final AutovalidateMode _autoValidateMode = AutovalidateMode.always;
  final phoneRegex = RegExp(
      r"^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$");

  String? selectedCity;
  List<String?> listCityName = [];
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String address = _addressController.text;
      String phone = _phoneController.text;
      String? city = selectedCity;

      DeliveryForm singletonInstance = DeliveryForm.singleton();

      singletonInstance.saveDeliveryFormToSharedPreferences(
        DeliveryForm(
          name: name,
          phone: phone,
          address: address,
          city: city));

      Navigator.pushNamed(context, CheckOutScreen.routeName);
    }
  }

  Widget loadCities() {
    List<CityModel>? listCity = [];
    return FutureBuilder<List<CityModel>?>(
      future: CityService.getCities(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CityModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          listCity = snapshot.data;
          listCityName = listCity!.map((e) => e.cityName).toList();
          return DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null) {
                return "Chọn thành phố";
              }
              return null;
            },
            value: selectedCity,
            onChanged: (newCityName) {
              setState(() {
                selectedCity = newCityName;
              });
            },
            items: [
              ...listCityName.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(
                    city!,
                  ),
                );
              }).toList(),
            ],
            decoration: const InputDecoration(
              labelText: 'Thành phố',
            ),
          );
        }

        return DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null) {
              return "Chọn thành phố";
            }
            return null;
          },
          onChanged: (value) {},
          value: selectedCity,
          items: const [
            DropdownMenuItem<String>(
              value: null,
              child: Text(
                "Empty city",
              ),
            )
          ],
          decoration: const InputDecoration(
            labelText: 'Thành phố',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          loadCities(),
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
