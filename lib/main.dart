import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/home.dart';
import 'package:practice_app/phone.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLogedIn = false;

  Future<bool> loginStatus() async {
     auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isLogedIn = false;
      } else {
        isLogedIn = true;
      }
    });

    return isLogedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loginStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
           const Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.green));
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.purple,
                backgroundColor: const Color(0XFF8C00FF),
                primaryColor:const Color(0XFF8C00FF)),
            home: isLogedIn ? const Home() : const PhoneNumberEntryScreen(),
            routes: {
              PhoneNumberEntryScreen.route: (context) =>
                  const PhoneNumberEntryScreen(),
              Home.route: (context) => const Home()
            },
          );
        });
  }
}
