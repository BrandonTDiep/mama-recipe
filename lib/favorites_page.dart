import 'package:flutter/material.dart';

import 'main.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});


  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("The counter has been increased to " + _counter.toString());
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Shopping list"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'App Logo - Screen No. 3',
            ),
            const Text(
              'My Demo App - Screen No. 3',
            ),
            const Text(
              'Login First Please',
            ),
            const Text(
              'You have pushed the button this many times!!!',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}