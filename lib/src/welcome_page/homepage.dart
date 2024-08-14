import 'package:flutter/material.dart';
import 'search_screen.dart';
import '../global_features/hamburger_menu.dart' ;


class MyHomePage extends StatefulWidget 
{
   const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//allows user to have access to everything, i.e. hamburger menu and search bar
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Welcome Page'),
      ),

     drawer: const CustomDrawer(), 

      body: Center(
        child: Container(
          padding: const EdgeInsets.all(125),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/entered.png"),
              fit: BoxFit.cover,
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hop',
              style: TextStyle(
                fontSize: 48,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the SearchScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: const Text('Go to Search Screen'),
            ),

          ],
        ),
      ),
      ),














      );
  
  }
}