import 'package:flutter/material.dart';
// ignore: unused_import
import '../global_features/hamburger_menu.dart';
// ignore: unused_import
import 'package:hop_app/src/articles/bonding.dart';
import 'package:hop_app/src/articles/gi_stasis_symptoms/gi_stasis_symptoms_main_page.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => ArticlePageState();
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

class ArticlePageState extends State<ArticlePage> {
 final List<Category> categories = [
    Category(
        name: 'Bonding',
        borderColor: Colors.green[200]!,
        image: 'lib/assets/images/cute-bunny-rabbits-kissing.png',
        destinationPage: const ArticlePageBonding()),
    Category(
        name: 'Diseases',
        borderColor: Colors.green[200]!,
        destinationPage: const ArticlePageBonding()),
    Category(
        name: 'Vaccines To Consider',
        borderColor: Colors.green[200]!,
        destinationPage: const ArticlePageBonding()),
    Category(
        name: 'Spay/Neauter Benefits and Process',
        borderColor: Colors.green[200]!,
        destinationPage: const ArticlePageBonding()),
    Category(
        name: 'Wonderful World of Droppings',
        borderColor: Colors.green[200]!,
        destinationPage: const ArticlePageBonding()),
    Category(
        name: 'GI Stasis Symptoms',
        borderColor: Colors.green[200]!,
        destinationPage: const GIMainPage())
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
