import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_features/hamburger_menu.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user;
  late FirebaseFirestore _firestore;
  late TextEditingController _bioController;
  late String _username;
  bool _isEditing = false;
  bool _isLoading = true;
  late String _profileImage;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _firestore = FirebaseFirestore.instance;
    _bioController = TextEditingController();
    _loadUserData();
  }

  // Gets user info from the database
  Future<void> _loadUserData() async {
    if (_user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('Users').doc(_user!.uid).get();
      setState(() {
        _username = userData.get('username') ?? 'Username';
        _bioController.text = userData.get('bio') ?? 'Bio: This is a sample bio.';
        _isLoading = false;
        _profileImage = userData.get('profile') ?? ''; // Load profile image URL
      });
    }
  }

  // Sends info to the database
  Future<void> _saveUserData() async {
    if (_user != null) {
      await _firestore.collection('Users').doc(_user!.uid).set({
        'username': _username,
        'bio': _bioController.text,
        'profile': _profileImage, // Save profile image URL
      });
      setState(() {
        _isEditing = false;
      });
    }
  }

  // To edit bio and save
  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _selectProfileImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _updateProfileImage(_profileImage); // Choose the current profile picture URL
                  },
                  child: const Text('Current Profile Picture'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _updateProfileImage('https://i.pinimg.com/originals/54/84/ab/5484ab9848993c638f62ca4117eddf83.jpg');
                  },
                  child: const Text('Profile Picture 1'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _updateProfileImage('https://avatarfiles.alphacoders.com/260/260321.jpg');
                  },
                  child: const Text('Profile Picture 2'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _updateProfileImage('https://cdn.shopify.com/s/files/1/0040/8997/0777/files/cute_rabbit_2_1024x1024.jpg?v=1696637386');
                  },
                  child: const Text('Profile Picture 3'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _updateProfileImage('https://www.vetcarepethospital.ca/wp-content/uploads/sites/247/2022/03/petrabbitcare-1-scaled.jpg');
                  },
                  child: const Text('Profile Picture 4'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to update the profile image URL
  void _updateProfileImage(String imageUrl) {
    setState(() {
      _profileImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const CustomDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is loading
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _isEditing ? _selectProfileImage : null, // Allow selection only in editing mode
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage: NetworkImage(_profileImage), // Display profile image
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _username,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  _isEditing
                      ? TextFormField(
                          controller: _bioController,
                          decoration: const InputDecoration(labelText: 'Bio'),
                        )
                      : Text(
                          _bioController.text,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                  const SizedBox(height: 20.0),
                  _isEditing
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveUserData,
                            child: const Text('Save Profile'),
                          ),
                        )
                      : Row(
                          children: [
                            ElevatedButton(
                              onPressed: _toggleEditing,
                              child: Text(_isEditing ? 'Done Editing' : 'Edit Profile'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
    );
  }
}