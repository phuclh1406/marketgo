import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matching/representation/widgets/info_cart.dart';
import 'package:matching/representation/widgets/upload_image_widget.dart';

import '../../core/helper/asset_helper.dart';
import '../../services/firebase_service.dart';
import 'login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = "/profile";
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                children: const [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('./assets/images/profile_pic.png'),
                    radius: 50,
                  ),
                  Positioned(
                    top: 70,
                    right: 2,
                    child: Icon(
                      Icons.edit_square,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Minh Quan',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey[200],
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Source Sans Pro"),
            ),
            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),

            // we will be creating a new widget name info carrd
            InfoCard(text: 'Info', icon: Icons.info, onPressed: () async {}),
            InfoCard(
                text: 'Wallet', icon: Icons.wallet, onPressed: () async {}),
            InfoCard(
                text: 'Trần Minh Quân',
                icon: Icons.person,
                onPressed: () async {}),
            InfoCard(
                text: '039238424', icon: Icons.phone, onPressed: () async {}),
            InfoCard(
                text: 'abc@gmail.com',
                icon: Icons.email,
                onPressed: () async {}),
            ElevatedButton(
              onPressed: () async {
                await FirebaseServices().googleSignOut();

                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(FontAwesomeIcons.powerOff),
                  ]),
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
