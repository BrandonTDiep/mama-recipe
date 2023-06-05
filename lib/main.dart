import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
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

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    return _suggestions.where ((element){
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Breakfast',
            ),
            Text(
              'Lunch',
            ),
            Text(
              'Dinner',
            ),
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
            label: 'Business',
            backgroundColor: Colors.red
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


