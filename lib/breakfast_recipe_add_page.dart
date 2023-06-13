import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'favorites_page.dart';
import 'main.dart';

class BreakfastRecipeAddPage extends StatefulWidget {
  const BreakfastRecipeAddPage({super.key});

  @override
  State<BreakfastRecipeAddPage> createState() => _BreakfastRecipeAddPageState();
}

class _BreakfastRecipeAddPageState extends State<BreakfastRecipeAddPage> {
  int _selectedIndex = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  void createBreakfastRecipe(){
    String imagePath = _image.path;
    Map<String, dynamic> newRecipe = {
      "name" : nameController.text,
      "time" : timeController.text,
      "servings" : servingsController.text,
      "ingredients" : ingredientsController.text,
      "directions" : directionsController.text,
      "image" : imagePath,
    };
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('breakfast-recipes').add(newRecipe)
        .then((value){
          print("Successfully added the recipe.");
        }).catchError((error){
          print("Failed to add the recipe.");
          print(error);
        });
    Navigator.pop(context, newRecipe);
  }

  late File _image;
  final imagePicker = ImagePicker();
  Future<void> _selectGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
       _image = File(image.path);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteRecipesPage()),
                (route) => false
        );
      }
      else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
                (route) => false
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.red,
        title: const Text("Add a Breakfast Recipe", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ), //
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 670),
          child: Column(
              children: [
                Container(
                  width: 350,
                  height: 60,
                  margin: const EdgeInsets.only(top: 14),
                  child: ElevatedButton.icon(
                    onPressed: _selectGallery,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Add a Photo"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 22, top: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Recipe Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Recipe Name',
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 22, top: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: TextField(
                      controller: timeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Time',
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 22, top: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Servings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: TextField(
                      controller: servingsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Servings',
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 22, top: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 22),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                        controller: ingredientsController,
                        decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingredients',
                      ),
                      keyboardType: TextInputType.multiline,
                        maxLines: null
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 22, top: 14),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Directions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 22),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                        controller: directionsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Directions',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 350,
                  margin: const EdgeInsets.only(top: 14),
                  child: ElevatedButton(
                    onPressed: createBreakfastRecipe,
                    child: const Text("Create Recipe"),
                  ),
                )
              ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        //backgroundColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}


