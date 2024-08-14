// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hop_app/src/bunny_care/grooming.dart';
import 'package:hop_app/src/bunny_care/miscellaneous.dart';
import 'package:hop_app/src/bunny_care/nutrition.dart';
import 'package:hop_app/src/bunny_care/running_space.dart';
import '../global_features/hamburger_menu.dart' ;
import '../bunny_care/housing.dart';

class ItemWidget extends StatelessWidget {
  final String itemName;
  final Widget destination;


   const ItemWidget({super.key, required this.itemName,  required this.destination});
  
//for style
 @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        itemName,
        style: const TextStyle(
          fontSize: 18.0,
          color: Color.fromARGB(255, 26, 71, 27) 
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination));
      },
    );
  }
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

//different pages for different section of items
class _ItemsPageState extends State<ItemsPage> {
  final Map<String, Widget> itemDestinations = {
    'Housing': const HousingPage(),
    'Grooming': const GroomPage(),
    'Nutrition': const FoodPage(),
    'Running Space': const SpacePage(),
    'Miscellaneous': const RandomPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bunny Care'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: itemDestinations.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ItemWidget(itemName: entry.key, destination: entry.value),
            );
          }).toList(),
        ),
      ),
    );
  }
}