import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'breakfast_data.dart';
import 'breakfast_page.dart';
import 'breakfast_recipes.dart';



class BreakfastRecipeAddPage extends StatefulWidget {
  final List<Breakfast> breakfastRecipes;
  const BreakfastRecipeAddPage(this.breakfastRecipes, {super.key});

  @override
  State<BreakfastRecipeAddPage> createState() => _BreakfastRecipeAddPageState();
}

class _BreakfastRecipeAddPageState extends State<BreakfastRecipeAddPage> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  void createBreakfastRecipe(){
    String imagePath = _image.path;
    Breakfast newRecipe = Breakfast(
      recipeNameController.text,
        imagePath,
      timeController.text,
      servingsController.text,
      ingredientsController.text,
      directionsController.text
    );

    widget.breakfastRecipes.add(newRecipe);

    Navigator.pop(
      context, widget.breakfastRecipes);
  }

  late File _image;
  final imagePicker = ImagePicker();

  Future<void> _selectGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
       _image = File(image.path);
       print(image.path);
    });
}
  @override
  Widget build(BuildContext context) {
    iconTheme: const IconThemeData(
        color: Colors.white
    );
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
              height: 80,
              margin: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                  onPressed: _selectGallery,
                  child: const Icon(Icons.camera_alt),
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
                  controller: recipeNameController,
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
            ElevatedButton(
                onPressed: createBreakfastRecipe,
                child: Text("Create Recipe")
            )
          ],
      ),
    );
  }
}


