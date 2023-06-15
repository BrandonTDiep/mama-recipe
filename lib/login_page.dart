import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/forgot_pwd_page.dart';
import 'package:mama_recipe_app/main.dart';
import 'package:mama_recipe_app/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              const Expanded(
                flex: 31,
                child: Image(
                  image: AssetImage('assets/logo2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 50,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(top: 5,bottom: 15, right: 35),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push( //change screens
                            context,
                            MaterialPageRoute(builder: (context) => const ForgotPwdPage()),
                          );
                        },
                        child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: 330,
                      height: 55,
                      margin: const EdgeInsets.only(top: 60, bottom: 5),
                      child: ElevatedButton(
                        child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value){
                                print("Successfully login!");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                                        (route) => false
                                );
                              }).catchError((error){
                                print("Failed to login");
                                print(error.toString());
                                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Incorrect email or password.\nTry Again.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  });
                                }
                                else if (emailController.text.isEmpty && passwordController.text.isEmpty){
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Please enter your email and password",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  });
                                }
                                else if (passwordController.text.isNotEmpty && emailController.text.isEmpty){
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Please enter your email",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  });
                                }
                                else if(passwordController.text.isEmpty && emailController.text.isNotEmpty){
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Please enter your password.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  });
                                }
                              });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14,


                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              onTap: () {
                                Navigator.push( //change screens
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignupPage()),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
