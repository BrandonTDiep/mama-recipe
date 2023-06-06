import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_recipes.dart';
import 'package:mama_recipe_app/main.dart';
import 'package:mama_recipe_app/shopping_list.dart';
import 'breakfast_data.dart';

class BreakfastPage extends StatefulWidget {
  const BreakfastPage({Key? key}) : super(key: key);

  @override
  State<BreakfastPage> createState() => _BreakfastPageState();
}

class _BreakfastPageState extends State<BreakfastPage> {
  int _selectedIndex = 0;

  String searchValue = '';
  final List<String> _suggestions = ['Apple', 'Pear','Grape'];
  final List<String> meals = ["Breakfast", "Lunch", "Dinner"];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    return _suggestions.where ((element){
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
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

  List<Breakfast> breakfastRecipes = [];

  _BreakfastPageState() {
    Breakfast b1 = Breakfast("Pho",
        "https://images.squarespace-cdn.com/content/v1/56cf7cfb0442626af6cd8f70/1617248613571-Z6NLJJ5GYBT8Z9AGTO6C/Pho+Above+%5Bmobile%5D.jpg?format=1000w",
        "1 hr",  "2", "Broth, noodles, meat", "Step 1: Broil Broth Step 2: Cook meat","A vietnamese noodle soup");
    Breakfast b2 = Breakfast("Chicken Rice",
        "https://www.thespruceeats.com/thmb/_JsWPTIIvL9hvlnkyrqCfjzJf34=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/hainanese-chicken-rice-very-detailed-recipe-3030408-hero-01-91c4d305f0ae400198cf7c63d8b7261f.jpg",
        "30 mins",
        "4", "rice, chicken", "Step 1: Cook Rice Step 2: Cook chicken","A chicken and rice dish");

    breakfastRecipes = [b1, b2];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          backgroundColor: Colors.red,
          title: const Text("Breakfast", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async =>
          await _fetchSuggestions(searchValue)
      ),
      body: ListView.builder(
          itemCount: breakfastRecipes.length,
          itemBuilder: (BuildContext context, int index) {
            return  Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Ink.image(
                    image:  NetworkImage(breakfastRecipes[index].imgUrl),
                    height: 150,
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BreakfastRecipesPage(breakfastRecipes[index])),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.only(left: 8, bottom: 5),
                    child: Text(
                      breakfastRecipes[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
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
            icon: Icon(Icons.create_sharp),
            label: 'Shopping List',
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
