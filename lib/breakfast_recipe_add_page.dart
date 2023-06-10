import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BreakfastRecipeAddPage extends StatefulWidget {
  const BreakfastRecipeAddPage({super.key});

  @override
  State<BreakfastRecipeAddPage> createState() => _BreakfastRecipeAddPageState();
}

class _BreakfastRecipeAddPageState extends State<BreakfastRecipeAddPage> {
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
    FirebaseFirestore.instance.collection("breakfast-recipes").add(newRecipe)
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
      body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: const Text("New Recipe", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: _selectGallery,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Add a Photo"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 22, top: 15),
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
              margin: const EdgeInsets.only(left: 22, top: 15),
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
              margin: const EdgeInsets.only(left: 22, top: 15),
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
              margin: const EdgeInsets.only(left: 22, top: 15),
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
              margin: const EdgeInsets.only(left: 22, top: 15),
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
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: createBreakfastRecipe,
                child: const Text("Create Recipe"),
              ),
            )
          ],
      ),
    );
  }
}


