import 'package:chats/controller/auth_provider.dart';
import 'package:chats/services/auth.dart';
import 'package:chats/views/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Enter OTP"),
      content: Column(
        children: <Widget>[
          Lottie.asset(
            'assets/otppss.json', // Replace with the path to your Lottie animation file
            height: 100, // Adjust the height as needed
            width: 100, // Adjust the width as needed
          ),
          SizedBox(height: 16),
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              labelText: 'OTP',
              hintText: 'Enter OTP',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text("Done"),
        ),
      ],
    ),
  );
}





class CustomAlertDialog extends StatelessWidget {
  final String veridicationId;
  CustomAlertDialog({
    required this.veridicationId,
    super.key,
  });
  final TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(66, 47, 129, 1),
      content: Lottie.asset(
        "assets/otppss.json",
        height: 150,
      ),
      actions: [
       
        Pinput(
          length: 6,
          showCursor: true,
          defaultPinTheme: PinTheme(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber)),
          ),
          onChanged: (value) {
            Provider.of<AuthPro>(context, listen: false).otpSetter(value);
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            String userotp =
                Provider.of<AuthPro>(context, listen: false).otpcode ??
                    "";
            verifyOtp(context, userotp);
          },
          child: Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 143, 157, 221),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void verifyOtp(context, String userotp) {
    AuthServices service = AuthServices();
    service.verifyOtp(
        verificationId: veridicationId,
        otp: userotp,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  Home(),
              ));
        });
  }
}
