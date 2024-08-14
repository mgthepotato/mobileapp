import 'package:flutter/material.dart';
import 'package:hop_app/src/global_features/hamburger_menu.dart' ;

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Profile 🐇'),
      ),
      drawer: const CustomDrawer(), 

      body: Stack(
        children: [
          // Circle Avatar Section
          const Positioned(
            top: 90.0,
            left: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Color.fromARGB(255, 196, 170, 216),
                  backgroundImage: NetworkImage('https://shorturl.at/fnuIP'),
                ),
                SizedBox(width: 20.0),
                Stack(
                  // Stack to overlay the emoji
                  alignment: Alignment.topRight,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Color.fromARGB(255, 196, 170, 216),
                      backgroundImage:
                          NetworkImage('https://shorturl.at/hkyQ5'),
                    ),
                    Text(
                      '🐰',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bio Input Section
          const Positioned(
            top: 220.0,
            left: 10.0,
            right: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bio:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                //MyBioInput(), // Assuming you have the MyBioInput widget
              ],
            ),
          ),

          Positioned(
            bottom: 5.0,
            left: 10.0,
            right: 10.0,
            child: Row(
              // Change to Row
              children: [
                Expanded(
                  child: Image.asset('lib/assets/images/rabbit-line-art.jpg'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
