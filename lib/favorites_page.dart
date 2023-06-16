import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/favorite_recipe_info.dart';

import 'main.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});


  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  int _selectedIndex = 0;
  var favoriteRecipes = [];

  _FavoriteRecipesPageState(){
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('favorites').get()
        .then((querySnapshot) {
          print("Successfully load all the favorite recipes");
          var recipeTmpList = [];
          querySnapshot.docs.forEach((element){
            recipeTmpList.add(element.data());
          });
          favoriteRecipes = recipeTmpList;
          setState(() {

          });
        }).catchError((error) {
          print("Failed to load all the favorite recipes.");
          print(error);
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
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
        title: const Text("Favorite Recipes", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 33,
        ),),
      ),
      body: ListView.builder(
          itemCount: favoriteRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            final String imagePath = '${favoriteRecipes[index]['image']}';
            return UnconstrainedBox(
              child: Container(
                width: 375,
                margin: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 15,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Ink.image(
                        image:  FileImage(File(imagePath)),
                        height: 230,
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FavoriteRecipeInfoPage(favoriteRecipes[index])),
                            );
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: const EdgeInsets.only(left: 8, bottom: 5),
                            child: Text(
                              '${favoriteRecipes[index]['name']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            margin: const EdgeInsets.only(left: 8, bottom: 5),
                            child: Wrap(
                              children: [
                                const Icon(
                                  Icons.access_alarm,
                                  size: 25,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${favoriteRecipes[index]['time']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
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
        currentIndex: 1,
        selectedItemColor: Colors.red,
        //backgroundColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
