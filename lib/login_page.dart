import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                      width: 330,
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: ElevatedButton(
                        child: Text("Login"),
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
                              });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 65),
                      child: const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        child: const Text("Sign up"),
                        onPressed: () {
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
      ),
    );
  }
}
