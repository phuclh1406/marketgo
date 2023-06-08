import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/mini_app_bar_container.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../model/store_model.dart';
import '../../services/store_service.dart';
import '../widgets/store_item_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  static const String routeName = '/stores_screen';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool isAPICallProcess = false;
  StoreModel? storeModel;
  Widget loadStores() {
    return FutureBuilder<List<StoreModel>?>(
      future: StoreService.getAllStores(),
      builder:
          (BuildContext context, AsyncSnapshot<List<StoreModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<StoreModel>? stores = snapshot.data;

          if (stores != null && stores.isNotEmpty) {

            return Column(
              children: [
                for (var i = 0; i < stores.length; i++)
                  if (stores[i].storeName != null || stores[i].image != null)
                    StoreItemWidget(
                      storeModel: stores[i],
                      onTap: () {},
                    )
              ],
            );
          } else {
            return const Text('No stores found.');
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SizedBox(); // Return an empty container or widget if data is null
        }
      },
    );
  }

  // Widget _buildImageStoreScreen(String name, String image) {
  //   return GestureDetector(
  //     // onTap: () {
  //     //   Navigator.of(context)
  //     //       .pushNamed(RecipeDetailScreen.routeName, arguments: name);
  //     // },
  //     child: Container(
  //       margin: const EdgeInsets.only(bottom: kDefaultPadding),
  //       child: Stack(
  //         alignment: Alignment.topRight,
  //         children: [
  //           ImageHelper.loadFromAsset(
  //             image,
  //             height: 200,
  //             fit: BoxFit.fitHeight,
  //             radius: BorderRadius.circular(kItemPadding),
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.all(kDefaultPadding),
  //             child: Icon(
  //               Icons.favorite,
  //               color: Colors.red,
  //             ),
  //           ),
  //           Positioned(
  //             left: kDefaultPadding,
  //             bottom: kDefaultPadding,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   name,
  //                   style: TextStyles.defaultStyle.whiteTextColor.bold,
  //                 ),
  //                 const SizedBox(
  //                   height: kItemPadding,
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.all(kMinPadding),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(kMinPadding),
  //                     color: Colors.white.withOpacity(0.4),
  //                   ),
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: const [
  //                       Icon(
  //                         Icons.star,
  //                         color: Color(0xffFFC107),
  //                       ),
  //                       SizedBox(
  //                         width: kItemPadding,
  //                       ),
  //                       Text('4.5')
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MiniAppBarContainerWidget(
      titleString: 'Danh sách cửa hàng',
      implementTraling: true,
      implementLeading: true,
      child: Column(children: [
        TextField(
          enabled: true,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Search your destination',
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.black,
                size: 14,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kItemPadding,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: kItemPadding),
          ),
          style: TextStyles.defaultStyle,
          onChanged: (value) {},
          onSubmitted: (String submitValue) {},
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ProgressHUD(
                      inAsyncCall: isAPICallProcess,
                      opacity: 0.3,
                      key: UniqueKey(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(children: [loadStores()]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
