import 'dart:io';
import 'package:flutter/material.dart';

class BreakfastRecipePage extends StatefulWidget {
  final Map<String, dynamic> breakfastRecipe;

  const BreakfastRecipePage(this.breakfastRecipe, {super.key});

  @override
  State<BreakfastRecipePage> createState() => _BreakfastRecipePageState();
}

class _BreakfastRecipePageState extends State<BreakfastRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.red,
        title: Text(widget.breakfastRecipe['name'], style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ), //
      body: Column(
        children: [
          Container(
            child: Expanded(
              flex: 9,
              child: Image(
                image:  FileImage(File(widget.breakfastRecipe['image'])),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    widget.breakfastRecipe['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 22),
                        child: const Text(
                          "Total Time: ",
                          style: TextStyle(
                              fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.breakfastRecipe['time'],
                          style: const TextStyle(
                            fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Servings: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 22),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.breakfastRecipe['servings'],
                          style: const TextStyle(
                            fontSize: 16,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5, top: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Ingredients:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 22, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.breakfastRecipe['ingredients'],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 22, bottom: 5, top: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Directions:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 22, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.breakfastRecipe['directions'],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
