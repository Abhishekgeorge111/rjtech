import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjtech/homepage.dart';

class FormPagess extends StatefulWidget {
  final String verificationid;
  const FormPagess({super.key, required this.verificationid});

  @override
  State<FormPagess> createState() => _FormPageState();
}

class _FormPageState extends State<FormPagess> {
  late List<TextEditingController> otpControllers;

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtpFromControllers() {
    return otpControllers.map((controller) => controller.text).join();
  }

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
                Text(
                  'Verification Code',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Enter the OTP',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 15),
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: const Color(0xFF512DA8),
                      showFieldAsBox: false,
                      fieldWidth: 40.0,
                      handleControllers: (controllers) {
                        for (int i = 0; i < controllers.length; i++) {
                          if (controllers[i] != null) {
                            otpControllers[i].text = controllers[i]!.text;
                          }
                        }
                      },
                      onSubmit: (String verificationCode) {
                        // This code is currently not used in your flow
                      },
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            shadowColor: Colors.black,
                            elevation: 5,
                          ),
                          onPressed: () async {
                            String otp = getOtpFromControllers();
                            if (otp.length != 6) {
                              log('Invalid OTP');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid OTP'),
                                ),
                              );
                              return;
                            }
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otp,
                              );
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ),
                                );
                              });
                            } catch (ex) {
                              log('Error: $ex');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Verification failed: $ex'),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Verify",
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
