// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class FoodPage extends StatefulWidget 
{
   const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}



class _FoodPageState extends State<FoodPage> { //allows items to be displayed
 final List<Map<String, String>> nutritionItems = [
    {'name': 'Fresh water', 'url': ''},
    {'name': 'Fresh salad veggies (NEVER iceberg lettuce)', 'url': ''},
    {'name': 'Limited pellets daily', 'url': 'https://www.petco.com/shop/en/petcostore/product/oxbow-garden-select-young-rabbit-food-4-lbs-3058064?store_code=2411&mr:device=c&mr:adType=pla_with_promotionlocal&cm_mmc=PSH%7CGGL%7CCCY%7CCCO%7CPM%7C0%7CkUMWcWiLY5b1EHQjK6kSR6%7C%7C%7C0%7C0%7C%7C%7C18145199970&gad_source=1&gclid=CjwKCAjwh4-wBhB3EiwAeJsppHvf17clMPH2w9WyFASYYVII2eV_kxmOpTO4XCvrmyQOOa6nUW_uqxoC7fcQAvD_BwE&gclsrc=aw.ds'},
    {'name': 'Unlimited timothy hay', 'url': 'https://www.petco.com/shop/en/petcostore/product/kaytee-natural-timothy-hay-for-rabbits-and-small-animals-639893?store_code=2411&mr:device=c&mr:adType=pla_with_promotionlocal&cm_mmc=PSH%7CGGL%7CCCY%7CCCO%7CPM%7C0%7CkUMWcWiLY5b1EHQjK6kSR6%7C%7C%7C0%7C0%7C%7C%7C18145199970&gad_source=1&gclid=CjwKCAjwh4-wBhB3EiwAeJsppEl7bMF5kRxdrPkWsSw922qfmPn2cVE1g8NFqAs8irLYDthdunCtFBoCWeUQAvD_BwE&gclsrc=aw.ds'},
    {'name': 'Wood (pesticide free)', 'url': 'https://store.binkybunny.com/products/willow-twigs-sticks-15#description'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition Items'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
drawer: const CustomDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(nutritionItems.length, (index) {
          final item = nutritionItems[index];
          return GestureDetector(
            onTap: () {
              if (item['url']!.isNotEmpty) { //so some items dont have url
                _launchURL(item['url']!);
              } else {
        
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Look at articles for more')),
                );
              }
            },
            child: Card(
              child: Center(
                child: Text(
                  item['name']!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}