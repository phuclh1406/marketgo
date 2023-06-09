import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/core/constants/dismension_constants.dart';
import 'package:matching/representation/widgets/info_cart.dart';
import 'package:matching/representation/widgets/upload_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/textstyle_constants.dart';
import '../../services/firebase_service.dart';
import 'login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = "/profile";
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('user_name');
    return userName ?? ''; // Return an empty string if userName is null
  }

  Future<String> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');
    return phone ?? ''; // Return an empty string if userName is null
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email ?? ''; // Return an empty string if userName is null
  }

  Future<String> getRoleName() async {
    final prefs = await SharedPreferences.getInstance();
    String? roleName = prefs.getString('role_name');
    return roleName ?? ''; // Return an empty string if userName is null
  }

  Future<String> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? image = prefs.getString('avatar');
    return image ?? ''; // Return an empty string if userName is null
  }

  Future<String> getYob() async {
    final prefs = await SharedPreferences.getInstance();
    String? birthday = prefs.getString('birthday');
    return birthday ?? ''; // Return an empty string if userName is null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 244, 245, 245),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImageUploaderWidget()));
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  FutureBuilder<String>(
                    future: getImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            FutureBuilder<String>(
              future: getUserName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey[200],
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Source Sans Pro"),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            FutureBuilder<String>(
              future: getRoleName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                      text: snapshot.data!,
                      icon: Icons.info,
                      onPressed: () async {});
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            FutureBuilder<String>(
              future: getYob(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.hasData == '') {
                  return InfoCard(
                      text: snapshot.data!,
                      icon: Icons.date_range,
                      onPressed: () async {});
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return InfoCard(
                      text: 'Chưa có dữ liệu',
                      icon: Icons.date_range,
                      onPressed: () async {});
                }
              },
            ),
            FutureBuilder<String>(
              future: getUserName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                      text: snapshot.data!,
                      icon: Icons.people,
                      onPressed: () async {});
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            FutureBuilder<String>(
              future: getPhone(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.hasData == '') {
                  return InfoCard(
                      text: snapshot.data!,
                      icon: Icons.phone,
                      onPressed: () async {});
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return InfoCard(
                      text: 'Chưa có dữ liệu',
                      icon: Icons.phone,
                      onPressed: () async {});
                }
              },
            ),
            FutureBuilder<String>(
              future: getEmail(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InfoCard(
                      text: snapshot.data!,
                      icon: Icons.email,
                      onPressed: () async {});
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            const SizedBox(height: kDefaultPadding / 2),
            GestureDetector(
              onTap: () async {
                await FirebaseServices().googleSignOut();

                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Container(
                  width: 310,
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  alignment: Alignment.center,
                  child: Text('Logout / Change Account',
                      style: TextStyles.defaultStyle.bold)),
            )
          ],
        ),
      ),
      // floatingActionButton: ElevatedButton.icon(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => SendMoney()));
      //   },
      //   label: Text('Send money'),
      //   icon: Icon(Icons.send),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}