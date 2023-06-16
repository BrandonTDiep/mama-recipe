import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mama_recipe_app/breakfast_page.dart';
import 'package:mama_recipe_app/dinner_page.dart';
import 'package:mama_recipe_app/login_page.dart';
import 'package:mama_recipe_app/lunch_page.dart';
import 'package:mama_recipe_app/favorites_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.deepOrange[50]
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[300],
        )
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences loginData;
  int _selectedIndex = 0;

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
    });
  }

  void signOut(){
    SharedPreferences.getInstance().then((pref){
      pref.setBool("login", false);
    });
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.red[300],
        title: const Text("Mama's Recipes", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 33,
        ),),
        actions: [
          IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout)
          )
        ],
      ), //
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, left: 15),
            child:  const Text("Mealtimes", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
            ),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: buildBreakfastCard()
              ),
              Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 18),
                  child: buildLunchCard()
              ),
              buildDinnerCard()
            ],
          ),
        ],
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
    );
  }
  Widget buildBreakfastCard() {
    return SizedBox(
      width: 385,
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const AssetImage('assets/breakfast.jpg'),
              height: 175,
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
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Text(
                'Breakfast',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildLunchCard() {
    return SizedBox(
      width: 385,
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const AssetImage('assets/lunch.jpg'),
              height: 175,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LunchPage()),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Text(
                'Lunch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildDinnerCard() {
    return SizedBox(
      width: 385,
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const AssetImage('assets/dinner.jpg'),
              height: 175,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DinnerPage()),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Text(
                'Dinner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}


