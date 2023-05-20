import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matching/model/user_model.dart';

import '../../config.dart';

class UserService {
  static var client = http.Client();

  static Future<UserModel?> getUserById(String userId) async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(
    Config.apiURL,
    '${Config.userAPI}/$userId', // Append the userId to the API endpoint
  );

  var response = await client.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var user = UserModel.fromJson(data);

    return user;
  } else {
    return null;
  }
}


//   static Future<bool> saveProduct(
//     ProductModel model,
//     bool isEditMode,
//     bool isFileSelected,
//   ) async {
//     var productURL = Config.productsAPI;

//     if (isEditMode) {
//       productURL = productURL + "/" + model.id.toString();
//     }

//     var url = Uri.http(Config.apiURL, productURL);

//     var requestMethod = isEditMode ? "PUT" : "POST";

//     var request = http.MultipartRequest(requestMethod, url);
//     request.fields["productName"] = model.productName!;
//     request.fields["productPrice"] = model.productPrice!.toString();

//     if (model.productImage != null && isFileSelected) {
//       http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
//         'productImage',
//         model.productImage!,
//       );

//       request.files.add(multipartFile);
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<bool> deleteProduct(productId) async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };

//     var url = Uri.http(
//       Config.apiURL,
//       Config.productsAPI + "/" + productId,
//     );

//     var response = await client.delete(
//       url,
//       headers: requestHeaders,
//     );

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
}
