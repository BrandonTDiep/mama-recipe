import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
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
                flex: 19,
                child: Image(
                  image: AssetImage('assets/logo2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: const Text(
                          'Create an account',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: nameController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
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
                      height: 45,
                      width: 330,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                        child: Text("Create Account"),
                        onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value) {
                                print("Successfully sign up the user!");

                                var userProfile = {
                                  'uid' : value.user?.uid,
                                  'name' : nameController.text,
                                  'email' : emailController.text,
                                };
                                FirebaseFirestore.instance.collection("users").doc(value.user?.uid).set(userProfile)
                                    .then((value){
                                      print("Successfully created the profile info.");
                                    }).catchError((error){
                                      print("Failed to create the profile info.");
                                      print(error);
                                });

                                Navigator.pop(context);
                              }).catchError((error){
                                print("Failed to sign up the user!");
                                print(error.toString());
                          });
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
