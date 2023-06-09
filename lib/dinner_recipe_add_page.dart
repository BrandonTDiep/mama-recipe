import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DinnerRecipeAddPage extends StatefulWidget {
  const DinnerRecipeAddPage({super.key});

  @override
  State<DinnerRecipeAddPage> createState() => _DinnerRecipeAddPageState();
}

class _DinnerRecipeAddPageState extends State<DinnerRecipeAddPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  void createDinnerRecipe(){
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
        .collection('dinner-recipes').add(newRecipe)
        .then((value){
          Navigator.pop(context, newRecipe);
        }).catchError((error){
        });
  }

  late File _image = File("assets/logo2.png");
  bool _imageSelected = false;

  final imagePicker = ImagePicker();
  Future<void> _selectGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      _imageSelected = true;
    });
  }

  Future<void> _selectCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      _imageSelected = true;
    });
  }

  void addPhoto(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text(
          "Choose Image",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: [
          Center(
            child: Column(
                children: [
                  TextButton(
                    onPressed: () async{
                      _selectCamera();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      _selectGallery();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text("Add a Dinner Recipe", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
      ), //
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: const Text("New Recipe", textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                GestureDetector(
                  onTap: addPhoto,
                  child: UnconstrainedBox(
                      child:
                      _imageSelected ?
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                          )
                      ):Container (
                        margin: const EdgeInsets.only(top: 10),
                        height: 60,
                        width: 350,
                        child: ElevatedButton.icon(
                            onPressed: addPhoto,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Add a Photo")
                        ),
                      )
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
                    width: 130,
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
                        maxLines: 7
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
                  margin: const EdgeInsets.only(left: 22, bottom: 40),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                        controller: directionsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Directions',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 7
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: createDinnerRecipe,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red[200]!),
                shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero
                    )
                )
            ),
            child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  child: const Text(
                    "Create Recipe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}


