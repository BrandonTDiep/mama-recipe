import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_recipes.dart';
import 'breakfast_data.dart';
import 'dart:math';


class BreakfastPage extends StatefulWidget {
  const BreakfastPage({Key? key}) : super(key: key);

  @override
  State<BreakfastPage> createState() => _BreakfastPageState();
}

class _BreakfastPageState extends State<BreakfastPage> {
  final List<String> entries = <String>['Alice', 'Ben', 'Thomas', 'Zack', 'John', 'Tom', 'Cindy', 'Frank', 'Hugo', 'James'];
  final List<String> phones = <String>['909-000-0000', '909-000-0001', '909-000-0002', '909-000-0003',
    '909-000-0004', '909-000-0005', '909-000-0006', '909-000-0007', '909-000-0008', '909-000-0009'];

  var friendsList = [
    {
      'name' : 'Alice',
      'phone' : '909-234-1234',
      'imageUrl' : 'https://www.clipartmax.com/png/middle/162-1623921_stewardess-510x510-user-profile-icon-png.png',
      'type' : 'CELL'
    },
    {
      'name' : 'John',
      'phone' : '123-234-1234',
      'imageUrl' : 'https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png',
      'type' : 'HOME'
    },
    {
      'name' : 'Zach',
      'phone' : '909-234-1234',
      'imageUrl' : 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'type' : 'WORK'
    }
  ];
  List<Breakfast> breakfastRecipes = [];

  _BreakfastPageState() {
    Breakfast f1 = Breakfast("Alice", "909-009-3434", "https://www.clipartmax.com/png/middle/162-1623921_stewardess-510x510-user-profile-icon-png.png", "HOME");
    Breakfast f2 = Breakfast("Ben", "909-232-3434", "https://www.shareicon.net/data/512x512/2016/09/15/829444_man_512x512.png", "WORK");
    Breakfast f3 = Breakfast("Zack", "123-009-3422", "https://cdn-icons-png.flaticon.com/512/3135/3135715.png", "CELL");
    Breakfast f4 = Breakfast("John", "405-009-3422", "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png", "HOME");

    breakfastRecipes = [f1, f2, f3, f4];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: breakfastRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: (){
                print("The item is clicked");
                Navigator.push( //change screens
                  context,
                  MaterialPageRoute(builder: (context) => BreakfastRecipesPage(breakfastRecipes[index])),
                );
              },
              title: Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(breakfastRecipes[index].imageUrl),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              breakfastRecipes[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          Text(
                              breakfastRecipes[index].phone
                          )
                        ],
                      ),
                      Spacer(),
                      Text(breakfastRecipes[index].type)
                    ],
                  )
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var rng = Random();
          var friend = {
            'name' : entries[rng.nextInt(entries.length)],
            'phone' : phones[rng.nextInt(phones.length)],
            'imageUrl' : 'https://www.clipartmax.com/png/middle/162-1623921_stewardess-510x510-user-profile-icon-png.png',
            'type' : 'HOME'
          };
          friendsList.add(friend);
          setState(() {

          });

        },
        child: Icon(Icons.add),

      ),
    );
  }
}
