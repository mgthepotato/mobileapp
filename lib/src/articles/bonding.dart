import 'package:flutter/material.dart';
// ignore: unused_import
import '../global_features/hamburger_menu.dart';




class ArticlePageBonding extends StatefulWidget {
  const ArticlePageBonding({super.key});

  @override
  State<ArticlePageBonding> createState() => ArticlePageBondingState();
}




class ArticlePageBondingState extends State<ArticlePageBonding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Red Page!'),
      ),
    );
  }
}