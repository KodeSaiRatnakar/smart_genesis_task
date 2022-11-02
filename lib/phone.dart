import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/otp.dart';

TextEditingController controller = TextEditingController();

class PhoneNumberEntryScreen extends StatefulWidget {
  const PhoneNumberEntryScreen({Key? key}) : super(key: key);

  static String route = "PhoneNumberEntryScreen";

  @override
  State<PhoneNumberEntryScreen> createState() => _PhoneNumberEntryScreenState();
}

class _PhoneNumberEntryScreenState extends State<PhoneNumberEntryScreen> {
  @override
  Widget build(BuildContext context) {
    var media_size = MediaQuery.of(context).size;

    String id = "";

    String enteredPhoneNum = '';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: media_size.width > 500
                ? media_size.width * 0.4
                : media_size.width * 0.9,
            height: media_size.height * 0.5,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(3, 6), // changes position of shadow
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Color(0XFF8C00FF), Color(0XffF637EC)],
                  end: Alignment.bottomRight,
                  begin: Alignment.topCenter,
                ),
                border: Border.all(
                    width: 0.0, color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: media_size.height * 0.05,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: media_size.width > 500
                          ? media_size.width * 0.3
                          : media_size.width * 0.75,
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: "Enter Mobile Number",
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: media_size.height * 0.015,
                        horizontal: media_size.width * 0.14),
                    child: InkWell(
                      onTap: () {
                        if (checkNum(controller.text)) {
                          showIndicator(context);
                          signIn(controller.text, context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                      child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Material(

                                      borderRadius: BorderRadius.circular(20),
                                        color:
                                            Theme.of(context).backgroundColor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Text(
                                              "Enter Correct Number",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 25.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Close",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  )));
                        }
                      },
                      child: Container(
                        // width: media_size.width*0.1,
                        height: media_size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(1, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).backgroundColor),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media_size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool checkNum(String num) {
  List<String> checkList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  if (num.length != 10) {
    return false;
  }
  for (int i = 0; i < 10; i++) {
    if (!checkList.contains(num[i])) {
      return false;
    }
  }

  return true;
}

void showIndicator(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()));
}

Future signIn(String number, BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: "+91${number}",
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpEntryScreen(
                    verificationid: verificationId,
                  )));
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const PhoneNumberEntryScreen()));
    },
  );
}
