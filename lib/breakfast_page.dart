import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_recipe_add_page.dart';
import 'package:mama_recipe_app/breakfast_recipe_info.dart';
import 'package:mama_recipe_app/main.dart';
import 'package:mama_recipe_app/favorites_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BreakfastPage extends StatefulWidget {
  const BreakfastPage({Key? key}) : super(key: key);

  @override
  State<BreakfastPage> createState() => _BreakfastPageState();
}

class _BreakfastPageState extends State<BreakfastPage> {
  int _selectedIndex = 0;

  var breakfastRecipes = [];

  @override
  void initState(){
    super.initState();
    loadBreakfastRecipes();
  }

  void loadBreakfastRecipes() async{
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('breakfast-recipes').get()
        .then((querySnapshot) {
          print("Successfully load all the recipes");
          var recipeTmpList = [];
          querySnapshot.docs.forEach((element){
            recipeTmpList.add(element.data());
          });
          breakfastRecipes = recipeTmpList;
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
      MaterialPageRoute(builder: (context) =>  const BreakfastRecipeAddPage()),
    );
    if(newRecipe != null){
      setState(() {
        breakfastRecipes.add(newRecipe);
      });
    }
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
        backgroundColor: Colors.red[300],
        title: const Text("Breakfast Recipes", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
      ),
      body: ListView.builder(
          itemCount: breakfastRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            final String imagePath = '${breakfastRecipes[index]['image']}';
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
                              MaterialPageRoute(builder: (context) => BreakfastRecipeInfoPage(breakfastRecipes[index])),
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
                              '${breakfastRecipes[index]['name']}',
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
                                  '${breakfastRecipes[index]['time']}',
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        //backgroundColor: Colors.red,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
      ),
    );
  }
}
