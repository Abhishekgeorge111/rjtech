import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:rjtech/otp.dart';
import 'package:rjtech/wxample.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign In',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Phone Number',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: phoneController,

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "Enter Phone Number",
                        prefixText: '+',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      // style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              shadowColor: Colors.black,
                              elevation: 5),
                          onPressed: () async {
                            String phoneNumber = '+' + phoneController.text;
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: phoneNumber,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException ex) {},
                                codeSent:
                                    (String verificationid, int? resendtoken) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FormPagess(
                                            verificationid: verificationid),
                                      ));
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {});
                            // phoneNumber: phoneController.text.toString());
                          },
                          child: const Text(
                            "verify Phone number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
