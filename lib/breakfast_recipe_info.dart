import 'dart:io';
import 'package:flutter/material.dart';

class BreakfastRecipeInfoPage extends StatefulWidget {
  final Map<String, dynamic> breakfastRecipe;

  const BreakfastRecipeInfoPage(this.breakfastRecipe, {super.key});

  @override
  State<BreakfastRecipeInfoPage> createState() => _BreakfastRecipeInfoPageState();
}

class _BreakfastRecipeInfoPageState extends State<BreakfastRecipeInfoPage> {
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
          Expanded(
            flex: 9,
            child: Image(
              image:  FileImage(File(widget.breakfastRecipe['image'])),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              color: Colors.orange[50],
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Text(
                      widget.breakfastRecipe['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
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
                          margin: EdgeInsets.only(right: 20),
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
                  const Divider(
                    color: Colors.black,
                    thickness: 0.4,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2, top: 5),
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
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.breakfastRecipe['ingredients'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2, top: 20),
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
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.breakfastRecipe['directions'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
