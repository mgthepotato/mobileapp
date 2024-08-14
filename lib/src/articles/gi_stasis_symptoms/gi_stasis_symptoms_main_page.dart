import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:hop_app/src/global_features/hamburger_menu.dart';
// ignore: unused_import
import 'package:hop_app/src/articles/bonding.dart';
import 'package:hop_app/src/articles/gi_stasis_symptoms/diarehea.dart';

class GIMainPage extends StatefulWidget {
  const GIMainPage({super.key});

  @override
  State<GIMainPage> createState() => GIMainPageState();
}

class Category {
  final String name;
  final Color borderColor;
  final String image;
  final Widget destinationPage;

  Category(
      {required this.name,
      required this.borderColor,
      this.image = 'lib/assets/images/User_Placeholder.png',
      required this.destinationPage});
}

class GIMainPageState extends State<GIMainPage> {
  final List<Category> categories = [
    Category(
        name: 'Diarehea',
        borderColor: Colors.green[200]!,
        image: 'lib/assets/images/cute-bunny-rabbits-kissing.png',
        destinationPage: const DiareheaPage()),
    Category(
        name: 'Hunched Posture',
        borderColor: Colors.green[200]!,
        image: 'lib/assets/images/cute-bunny-rabbits-kissing.png',
        destinationPage: const ArticlePageBonding())

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Page'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: categories
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => e.destinationPage),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: e.borderColor, width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              e.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      )),
    );
  }
}
