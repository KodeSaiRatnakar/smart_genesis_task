import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

TextEditingController otp = TextEditingController();
class OtpEntryScreen extends StatefulWidget {
  final String verificationid;

  const OtpEntryScreen({required this.verificationid, Key? key})
      : super(key: key);

  static String route = "OTPEntryScreen";

  @override
  State<OtpEntryScreen> createState() => _OtpEntryScreenState();
}

class _OtpEntryScreenState extends State<OtpEntryScreen> {
  @override
  Widget build(BuildContext context) {
    var media_size = MediaQuery.of(context).size;

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
                    child: Container(
                      width: media_size.width > 500
                          ? media_size.width * 0.3
                          : media_size.width * 0.75,
                      child: TextField(
                        controller: otp,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: "Enter OTP",
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
                      onTap: () async {

                        if(isCorrectOTP(otp.text)){
                        FirebaseAuth auth = FirebaseAuth.instance;
showIndicator(context);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otp.text);

                        await auth.signInWithCredential(credential);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                      }else{
                          showError(context);
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
                                   const  Offset(1, 3), // changes position of shadow
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

void showIndicator(BuildContext context)
{
  showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator()));
}

void showError(BuildContext context){
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
                          "Enter Correct OTP",
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


bool isCorrectOTP(String otp){
  List<String> checkList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  if(otp.isEmpty){
    return false;
  }
  for(int i=0;i<otp.length;i++){
    if(!checkList.contains(otp[i])){
      return false;
    }
  }

  return true;
}