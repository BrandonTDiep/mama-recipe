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

  @override
  void initState(){
    super.initState();
    loadDinnerRecipes();
  }

  void loadDinnerRecipes() async{
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").doc(currentUser?.uid)
        .collection('dinner-recipes').get()
        .then((querySnapshot) {
          var recipeTmpList = [];
          querySnapshot.docs.forEach((element){
            recipeTmpList.add(element.data());
          });
          dinnerRecipes = recipeTmpList;
          setState(() {

          });
        }).catchError((error) {
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

  void _infoRecipe(dinnerRecipe) async {
    final newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  DinnerRecipeInfoPage(dinnerRecipe)),
    );
    if(newRecipe != null){
      setState(() {
        dinnerRecipes.remove(newRecipe);
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
        title: const Text("Dinner Recipes", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
      ),
      body: ListView.builder(
          itemCount: dinnerRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            final String imagePath = '${dinnerRecipes[index]['image']}';
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
                            _infoRecipe(dinnerRecipes[index]);
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
                                  '${dinnerRecipes[index]['time']}',
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
