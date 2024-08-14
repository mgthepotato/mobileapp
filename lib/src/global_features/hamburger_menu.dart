import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:hop_app/src/main/base.dart';
import 'package:hop_app/src/private_profile/pprofile.dart';
import 'package:hop_app/src/welcome_page/homepage.dart';
import 'package:hop_app/src/articles/articles_main_page.dart';
import '../timers/alarms.dart';
import '../emergency/checklist.dart';
import '../bunny_care/bunny_items.dart';
import 'getusername.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late User? _user; 
  late FirebaseFirestore _firestore; 
  late String _username; 
  bool _isLoading = true; 
  late String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _initializeVariables();
    _loadUserData();
  }

  Future<void> _initializeVariables() async {
    _user = FirebaseAuth.instance.currentUser;
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('Users').doc(_user!.uid).get();
      setState(() {
        _username = userData.get('username') ?? 'Username';
        _isLoading = false;
         _profileImageUrl = userData.get('profile') ?? '';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Material(
            //lets user go to their page and allows them to edit
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
              //displays user's username and profile picture
              child: FutureBuilder<String?>(
                future: Username.getUsername(), // Use getUsername method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
                    return const UserAccountsDrawerHeader(
                      margin: EdgeInsets.only(top: 10.0),
                      currentAccountPictureSize: Size(50.0, 50.0),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('lib/assets/images/User_Placeholder.png'),
                      ),
                      accountName: Text('Loading...'), // Placeholder text while loading
                      accountEmail: Text('🐇🐇', style: TextStyle(height: 1.0)),
                    );
                  } else {
                    return UserAccountsDrawerHeader(
                      margin: const EdgeInsets.only(top: 10.0),
                      currentAccountPictureSize: const Size(50.0, 50.0),
                      currentAccountPicture:  CircleAvatar(
                        backgroundImage: NetworkImage(_profileImageUrl)
                      ),
                      accountName: Text(
                        _username,
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      accountEmail: const Text('🐇🐇', style: TextStyle(height: 1.0)),
                    );
                  }
                },
              ),
            ),
          ),
          //different pages for users to tap
          ListTile(
            title: const Text('BunnyCare'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemsPage()));
            },
          ),
          ListTile(
            title: const Text('Feed Timer'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AlarmPage()));
            },
          ),
          ListTile(
            title: const Text('Articles'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ArticlePage()));
            },
          ),
          ListTile(
            title: const Text('Emergency Checklist'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChecklistPage()));
            },
          ),
          
           
        //easy taps for user
          const Spacer(), 
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp())); 
            },
          ),
        ],
      ),
      
    );
  }
}
