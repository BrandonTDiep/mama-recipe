import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'main.dart';

class BreakfastRecipeInfoPage extends StatefulWidget {
  final Map<String, dynamic> breakfastRecipe;

  const BreakfastRecipeInfoPage(this.breakfastRecipe, {super.key});

  @override
  State<BreakfastRecipeInfoPage> createState() => _BreakfastRecipeInfoPageState();
}

class _BreakfastRecipeInfoPageState extends State<BreakfastRecipeInfoPage> {
  int _selectedIndex = 0;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
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

   void _loadFavoriteState() async{
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('favorites')
        .where("name", isEqualTo: widget.breakfastRecipe['name'])
        .where("time", isEqualTo: widget.breakfastRecipe['time'])
        .where("servings", isEqualTo: widget.breakfastRecipe['servings'])
        .where("ingredients", isEqualTo: widget.breakfastRecipe['ingredients'])
        .where("directions", isEqualTo: widget.breakfastRecipe['directions'])
        .where("image", isEqualTo: widget.breakfastRecipe['image'])
        .get()
        .then((value){
          if(value.docs.isNotEmpty){
            setState(() {
              isFavorite = true;
            });
          }
        }).catchError((error){
        });
  }

  void toggleFavorite(){
    setState(() {
      isFavorite = !isFavorite;
      if(isFavorite){
        FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
            .collection('favorites').add(widget.breakfastRecipe)
            .then((value){
            }).catchError((error){
            });
      }
      else{
        FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
            .collection('favorites').where("name", isEqualTo: widget.breakfastRecipe['name']).get()
            .then((value){
              String docId = value.docs.first.id;
              FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
                  .collection('favorites').doc(docId).delete()
                  .then((value){
                  }).catchError((error){
                  });
            }).catchError((error){
            });
      }
    });
  }

  void deleteBreakfastRecipe(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text(
          "Delete Recipe",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        content: const Text(
          "Are you sure you want to delete this recipe?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async{
                  FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
                      .collection('favorites')
                      .where("name", isEqualTo: widget.breakfastRecipe['name'])
                      .where("time", isEqualTo: widget.breakfastRecipe['time'])
                      .where("servings", isEqualTo: widget.breakfastRecipe['servings'])
                      .where("ingredients", isEqualTo: widget.breakfastRecipe['ingredients'])
                      .where("directions", isEqualTo: widget.breakfastRecipe['directions'])
                      .where("image", isEqualTo: widget.breakfastRecipe['image'])
                      .get()
                      .then((value){
                        value.docs.forEach((value){
                          value.reference.delete();
                        });
                      }).catchError((error){
                      });
                  FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
                      .collection('breakfast-recipes')
                      .where("name", isEqualTo: widget.breakfastRecipe['name'])
                      .where("time", isEqualTo: widget.breakfastRecipe['time'])
                      .where("servings", isEqualTo: widget.breakfastRecipe['servings'])
                      .where("ingredients", isEqualTo: widget.breakfastRecipe['ingredients'])
                      .where("directions", isEqualTo: widget.breakfastRecipe['directions'])
                      .where("image", isEqualTo: widget.breakfastRecipe['image'])
                      .get()
                      .then((value){
                        value.docs.forEach((value){
                          value.reference.delete();
                        });
                        Navigator.pop(context);
                        Navigator.pop(context, widget.breakfastRecipe);
                      }).catchError((error){
                      });
                  },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ]
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
        backgroundColor: Colors.red[300],
        title: Text(widget.breakfastRecipe['name'], style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        actions: [
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: toggleFavorite,
                child: Icon(
                  size: 28,
                  isFavorite ? Icons.favorite: Icons.favorite_border,
                  color: isFavorite ? Colors.red[900] : Colors.white,
                ),
              )
          ),
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: deleteBreakfastRecipe,
                child: const Icon(
                  color: Colors.white,
                  Icons.delete,
                  size: 28,
                ),
              )
          ),
        ],
      ),
      body: Container(
        color: Colors.orange[50],
        child: ListView(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.34,
                child: widget.breakfastRecipe['image'].startsWith("assets/")
                    ? Image.asset(widget.breakfastRecipe["image"],
                  fit: BoxFit.cover,
                ) : Image(
                  image:  FileImage(File(widget.breakfastRecipe['image'])),
                  fit: BoxFit.cover,
                )
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          widget.breakfastRecipe['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Total Time: ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.breakfastRecipe['time'],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Servings: ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.breakfastRecipe['servings'],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 350,
                  child: Divider(
                    color: Colors.black,
                    thickness: 0.6,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      children: (widget.breakfastRecipe['ingredients'] as String).split("\n")
                          .where((ingredient) {
                            return ingredient.trim().isNotEmpty;
                          })
                          .toList()
                          .asMap()
                          .entries
                          .map<Widget>((ingredients){
                            var ingredient = ingredients.value;
                            return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "• ",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Expanded(
                                        child: Text(
                                          ingredient,
                                          style: const TextStyle(fontSize: 18),
                                        )
                                    )
                                  ],
                                )
                            );}).toList(),
                    ),
                  ),
                ),
                Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 40),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Directions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (widget.breakfastRecipe['directions'] as String).split("\n")
                          .where((direction) {
                            return direction.trim().isNotEmpty;
                          })
                          .toList()
                          .asMap()
                          .entries
                          .map<Widget>((directions){
                            var index = directions.key + 1;
                            var direction = directions.value;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$index. ",
                                    style: const TextStyle(fontSize: 17)
                                  ),
                                  Expanded(
                                    child: Text(
                                        direction,
                                        style: const TextStyle(fontSize: 18)
                                    ),
                                  )
                                ],
                              ),
                            );
                      }).toList(),
                    ),
                  )
                )
              ],
            ),
          ],
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
