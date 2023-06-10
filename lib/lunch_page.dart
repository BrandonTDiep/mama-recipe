import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_recipe_add_page.dart';
import 'package:mama_recipe_app/breakfast_recipe_info.dart';
import 'package:mama_recipe_app/main.dart';
import 'package:mama_recipe_app/shopping_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LunchPage extends StatefulWidget {
  const LunchPage({Key? key}) : super(key: key);

  @override
  State<LunchPage> createState() => _LunchPageState();
}

class _LunchPageState extends State<LunchPage> {
  int _selectedIndex = 0;

  var breakfastRecipes = [];

  _LunchPageState(){
    FirebaseFirestore.instance.collection("breakfast-recipes").get()
        .then((querySnapshot) {
      print("Successfully load all the recipes");
      print(querySnapshot);
      var recipeTmpList = [];
      querySnapshot.docs.forEach((element){
        breakfastRecipes.add(element.data());
        recipeTmpList.add(element.data());
        print(element.data());
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShoppingListPage()),
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
        title: const Text("Breakfast Recipes", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ), //
      body: ListView.builder(
          itemCount: breakfastRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            print(breakfastRecipes.length);
            final String imagePath = '${breakfastRecipes[index]['image']}';
            return  Container(
              child: Card(
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
                            '${breakfastRecipes[index]['time']}',
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
            icon: Icon(Icons.create_sharp),
            label: 'Shopping List',
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
