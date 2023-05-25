import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/button_widget.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/image_helper.dart';
import '../../model/recipe_model.dart';
import 'dash_line_widget.dart';

class SelectIngredientsInRecipe extends StatefulWidget {
  const SelectIngredientsInRecipe(
      {Key? key, this.initData = 0, required this.icon, required this.value})
      : super(key: key);

  final int initData;
  final String icon;
  final String value;

  @override
  State<SelectIngredientsInRecipe> createState() =>
      SelectIngredientsInRecipeWidget();
}

class SelectIngredientsInRecipeWidget extends State<SelectIngredientsInRecipe> {
  late final TextEditingController _textEditingController;

  final FocusNode _focusNode = FocusNode();

  late int number;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.initData.toString())
          ..addListener(() {
            number = int.parse(_textEditingController.text);
          });
    number = widget.initData;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kTopPadding),
              color: Colors.white),
          margin: const EdgeInsets.only(bottom: kMediumPadding),
          padding: const EdgeInsets.all(kMediumPadding),
          child: Row(
            children: [
              ImageHelper.loadFromAsset(widget.icon,
                  width: 40, fit: BoxFit.fill),
              const SizedBox(
                width: 20,
              ),
              Text(widget.value),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (number > 1) {
                    setState(() {
                      number--;
                      _textEditingController.text = number.toString();
                      if (_focusNode.hasFocus) {
                        _focusNode.unfocus();
                      }
                    });
                  }
                },
                child: ImageHelper.loadFromAsset(
                  AssetHelper.ico_decre,
                ),
              ),
              Container(
                height: 35,
                width: 40,
                padding: const EdgeInsets.only(left: 3),
                alignment: Alignment.center,
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.center,
                  focusNode: _focusNode,
                  enabled: true,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]*$')), // Only allow digits
                    FilteringTextInputFormatter.deny(
                        RegExp(r'^0[0-9]*$')), // Prevent leading zeros
                    FilteringTextInputFormatter.deny(
                        RegExp(r'^[1-9][0-9]*\D')), // Prevent negative values
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 18,
                    ),
                  ),
                  onChanged: (value) {},
                  onSubmitted: (String submitValue) {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    number++;
                    _textEditingController.text = number.toString();
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    }
                  });
                },
                child: ImageHelper.loadFromAsset(AssetHelper.ico_incre),
              ),
            ],
          ),
        );
      },
    );
  }
}
