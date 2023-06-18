import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

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
              Expanded(
                flex: 19,
                child: Stack(
                  children: [
                    const Image(
                      image: AssetImage('assets/logo2.png'),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 25,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
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
                      height: 55,
                      width: 330,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                        child: const Text("Create Account"),
                        onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value) {
                                var userProfile = {
                                  'uid' : value.user?.uid,
                                  'name' : nameController.text,
                                  'email' : emailController.text,
                                };
                                FirebaseFirestore.instance.collection("users").doc(value.user?.uid).set(userProfile)
                                    .then((value){
                                      SharedPreferences.getInstance().then((pref){
                                        pref.setBool("login", true);
                                      });
                                    }).catchError((error){
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                                        (route) => false
                                );
                              }).catchError((error){
                                if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.length < 6){
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Password should be at least 6 characters",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  });
                                }
                                else{
                                  showDialog(context: context, builder: (context){
                                    return const AlertDialog(
                                      title: Text(
                                        "Please fill out all details.",
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
