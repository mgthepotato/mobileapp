import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class VetPage extends StatefulWidget 
{
   const VetPage({super.key});

  @override
  State<VetPage> createState() => _VetPageState();
}



class _VetPageState extends State<VetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'It''s okay!',
          style: TextStyle(fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'It is not GI Stasis yet but it is developing,\ngo to the vet when you can.\n Keep an eye on your pet',
          style: TextStyle(fontSize: 24.0), 
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}