import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class StasisPage extends StatefulWidget 
{
   const StasisPage({super.key});

  @override
  State<StasisPage> createState() => _StasisPageState();
}


//displays text
class _StasisPageState extends State<StasisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oh no!',
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Keep calm!\nYour bunny is experiencing GI Stasis\nConsult a vet right away.',
          style: TextStyle(fontSize: 24.0), 
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}