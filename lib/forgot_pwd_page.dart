import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({super.key});

  @override
  State<ForgotPwdPage> createState() => _ForgotPwdPageState();
}

class _ForgotPwdPageState extends State<ForgotPwdPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child:
            const Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: const Text(
                'Enter your email address to receive instructions to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
            child: TextField(
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            width: 220,
            height: 45,
            margin: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              child: const Text(
                  'SEND RESET INSTRUCTIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim())
                    .then((value){
                      print("Successfully sent email to reset password!");
                      showDialog(context: context, builder: (context){
                        return const AlertDialog(
                          title: Text(
                            "Password reset instructions have been sent to your email.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      });
                    }).catchError((error){
                      print("Failed to send email to reset password");
                      print(error.toString());
                      showDialog(context: context, builder: (context){
                        return const AlertDialog(
                          title: Text(
                            "This email does not exist in our records.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      });
                    });
                },
            ),
          ),

        ],
      ),
    );
  }
}
