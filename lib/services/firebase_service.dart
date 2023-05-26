

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  void printWrapped(String text) => RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        FirebaseAuth fAuth = FirebaseAuth.instance;
        final User? firebaseUser = (await fAuth
                .signInWithCredential(authCredential)
                // ignore: body_might_complete_normally_catch_error
                .catchError((msg) {}))
            .user;
        if (firebaseUser != null) {
          String token = await firebaseUser.getIdToken();
          printWrapped('Get token from firebase: $token');
          await sendTokenToApi(token);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('tokenfirebase', token);
        }
      }
    } on FirebaseAuthException catch (e) {
      printWrapped('error: ${e.message}');
      rethrow;
    }
  }

  

  Future<void> sendTokenToApi(String token) async {
    const url = 'https://market-go.cyclic.app/api/v1/auth/login-google';
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    final TokenPusnoti = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'token': token,
      "role": "user",
      "device_token": TokenPusnoti,
    });
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    final responseData = json.decode(response.body);
    final accesstoken = responseData['access_token'];
      printWrapped('AcessToken: $accesstoken');
      printWrapped('Token đã được gửi lên API. Dữ liệu trả về: $responseData');

    if (responseData != null && responseData['data'] != null) {
      final name = responseData['data']['user_name'];
      final phone = responseData['data']['phone'];
      final email = responseData['data']['email'];
      final password = responseData['data']['password'];
      final idUser = responseData['data']['user_id'];
      final roleId = responseData['data']['role_id']['id'];
      final yob = responseData['data']['birthday'];
      final address = responseData['data']['address'];
      final accessChangePassword = responseData['data']['accessChangePassword'];
      final avatar = responseData['data']['avatar'];
      final status = responseData['data']['status'];

      
      // Lưu trữ access token bằng Shared Preferences
      if (accesstoken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accesstoken', accesstoken);
      }
      if (idUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', idUser);
      }
      if (name != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', name);
      }
      if (phone != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', phone);
      }
      if (email != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
      }
      if (password != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('password', password);
      }
      if (roleId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('role_Id', roleId);
      }
      if (yob != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('birthday', yob);
      }
      if (address != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('address', address);
      }
      if (accessChangePassword != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessChangePassword', accessChangePassword);
      }
      if (avatar != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('avatar', avatar);
      }
      if (status != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('status', status);
      }

      // Rest of your code...
    } else {
      printWrapped('Invalid response data');
    }
}

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
