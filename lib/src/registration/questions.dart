import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hop_app/src/private_profile/pprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hop_app/src/welcome_page/homepage.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Create the controllers

  int numberOfBunnies = 1; // Default value
  late List<String> bunnyNames = List.filled(numberOfBunnies, '');
  late List<TextEditingController> bunnyControllers = List.generate(
      numberOfBunnies, (index) => TextEditingController());
  // Controllers for bunny name fields

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController(); // Here!

  final _formKey = GlobalKey<FormState>();

  // Add a loading indicator variable
  bool _isLoading = false;

  String? _profileImage; // Store the selected profile image URL

  // Define a list of predefined profile pictures
  final List<String> profilePictures = [
    'https://i.pinimg.com/originals/54/84/ab/5484ab9848993c638f62ca4117eddf83.jpg',
    'https://avatarfiles.alphacoders.com/260/260321.jpg',
    'https://cdn.shopify.com/s/files/1/0040/8997/0777/files/cute_rabbit_2_1024x1024.jpg?v=1696637386',
    'https://www.vetcarepethospital.ca/wp-content/uploads/sites/247/2022/03/petrabbitcare-1-scaled.jpg',
  ];

  // Function to handle registration
  Future<void> _registerUser() async {
    // Check form validation
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Show loading indicator
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Get the uid
        String? uid = userCredential.user?.uid;

        // Create a new document for the user
        if (uid != null) {
          // Create a new document for the user
          DocumentReference userDoc =
              FirebaseFirestore.instance.collection('Users').doc(uid);

          List<String> bunnyNames =
              bunnyControllers.map((controller) => controller.text).toList();

          // Add the user's information to the document
          userDoc.set({
            'name': nameController.text,
            'username': usernameController.text,
            'bunnies': bunnyNames
                .where((name) => name.isNotEmpty)
                .map((name) => {
                      'bunnyId': 'bun${DateTime.now().millisecondsSinceEpoch}',
                      'name': name,
                    })
                .toList(),
            'bio': bioController.text,
            'profile': _profileImage ?? '', // Use the selected profile image
          });
        }

        if (mounted) {
          // Registration success
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User registered successfully!")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle auth errors (e.g., weak-password, email-already-in-use)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(e.message ?? "Registration failed. Please try again.")));
        }
      } finally {
        setState(() {
          // Hide loading indicator
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Name'),
                const SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                  ),
                ),

                const Text('Make your Username 🐇'),
                const SizedBox(height: 5),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Username',
                  ),
                ),

                const SizedBox(height: 10),
                const Text('Email'),
                const SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email',
                  ),
                ),

                const SizedBox(height: 10),
                const Text('Password'),
                const SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,

                  // Use the existing controller
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      // Enforce length
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password',
                  ),
                ),

                const Text('Select the number of bunnies:'),
                DropdownButton<int>(
                  value: numberOfBunnies,
                  items: List.generate(10, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      numberOfBunnies = value!;
                      bunnyControllers = List.generate(numberOfBunnies, (index) => TextEditingController());
                    });
                  },
                ),

                Column(
                  children: List.generate(numberOfBunnies, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // Add vertical padding
                      child: TextFormField(
                        controller: bunnyControllers[index],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter bunny name',
                        ),
                      ),
                    );
                  }),
                ),

                const Text('Bio'),
                const SizedBox(height: 5),
                TextFormField(
                  controller: bioController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Tell us about yourself!',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: profilePictures.map((String url) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _profileImage = url;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(url),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _registerUser, // Disable while loading
                  child: _isLoading
                      ? const SizedBox(
                          // Loading indicator
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(color: Colors.white))
                      : const Text('Register', style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}