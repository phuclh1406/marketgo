// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:matching/representation/screen/login_screen.dart';
// import 'package:matching/services/firebase_service.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   static String routeName = '/profile_screen';

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         await FirebaseServices().googleSignOut();

//         // ignore: use_build_context_synchronously
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const LoginPage()));
//       },
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(FontAwesomeIcons.powerOff),
//         ]
//         ),
//     );
//   }
// }
