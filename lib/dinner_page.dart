import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/main.dart';
import 'package:mama_recipe_app/favorites_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dinner_recipe_add_page.dart';
import 'dinner_recipe_info.dart';


class DinnerPage extends StatefulWidget {
  const DinnerPage({Key? key}) : super(key: key);

  @override
  State<DinnerPage> createState() => _DinnerPageState();
}

class _DinnerPageState extends State<DinnerPage> {
  int _selectedIndex = 0;

  var dinnerRecipes = [];

  _DinnerPageState(){
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('dinner-recipes').get()
        .then((querySnapshot) {
          print("Successfully load all the recipes");
          print(querySnapshot);
          var recipeTmpList = [];
          querySnapshot.docs.forEach((element){
            recipeTmpList.add(element.data());
            print(element.data());
          });
          dinnerRecipes = recipeTmpList;
          setState(() {

          });
        }).catchError((error) {
          print("Failed to load all the recipes.");
          print(error);
        });
  }

  void _addRecipe() async {
    final newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  const DinnerRecipeAddPage()),
    );
    if(newRecipe != null){
      setState(() {
        dinnerRecipes.add(newRecipe);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoriteRecipesPage()),
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
        title: const Text("Dinner Recipes", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ), //
      body: ListView.builder(
          itemCount: dinnerRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            print(dinnerRecipes.length);
            final String imagePath = '${dinnerRecipes[index]['image']}';
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Ink.image(
                    image:  FileImage(File(imagePath)),
                    height: 150,
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DinnerRecipeInfoPage(dinnerRecipes[index])),
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
                          '${dinnerRecipes[index]['name']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.only(left: 8, bottom: 5),
                        child: Text(
                          '${dinnerRecipes[index]['time']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        //backgroundColor: Colors.red,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
      ), // Th
    );
  }
}
