import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class OkPage extends StatefulWidget 
{
   const OkPage({super.key});

  @override
  State<OkPage> createState() => _OkPageState();
}



class _OkPageState extends State<OkPage> {
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
          'Not really GI stasis, might be something else.\n See a vet when you can',
          style: TextStyle(fontSize: 24.0), 
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}