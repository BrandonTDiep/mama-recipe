import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_page.dart';
import 'package:mama_recipe_app/dinner_page.dart';
import 'package:mama_recipe_app/lunch_page.dart';
import 'package:mama_recipe_app/shopping_list.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        )
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchValue = '';
  final List<String> _suggestions = ['Apple', 'Pear','Grape'];
  final List<String> meals = ["Breakfast", "Lunch", "Dinner"];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    return _suggestions.where ((element){
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShoppingListPage(title: "My Page No. 3")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
          backgroundColor: Colors.red,
          title: Text(widget.title, style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async =>
              await _fetchSuggestions(searchValue)
        ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBreakfastCard(),
            Container(
                margin: EdgeInsets.only(top: 25, bottom: 25),
                child: buildLunchCard()
            ),
            buildDinnerCard()

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_sharp),
            label: 'Shopping List',
            backgroundColor: Colors.red
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  Widget buildBreakfastCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: const NetworkImage(
              'https://assets-westchestermagazine-com.s3-accelerate.amazonaws.com/2020/09/all-day-breakfast-in-westchester.jpg',
            ),
            height: 180,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BreakfastPage()),
                );
              },
            ),
          ),
          const Text(
            'Breakfast',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildLunchCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: const NetworkImage(
              'https://popmenucloud.com/lmkrqzuh/4691eba0-150b-40f5-b335-b2ba15b57424',
            ),
            height: 180,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LunchPage(title: "My Page No. 3")),
                );
              },
            ),
          ),
          const Text(
            'Lunch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildDinnerCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: const NetworkImage(
              'https://www.newzealand.com/assets/Operator-Database/img-1637315723-7218-10523-tss-walter-peak_september2018_72dpi_070__aWxvdmVrZWxseQo_CropResizeWzk0MCw1MzAsNzUsImpwZyJd.jpg',
            ),
            height: 180,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DinnerPage(title: "My Page No. 3")),
                );
              },
            ),
          ),
          const Text(
            'Dinner',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }


}


