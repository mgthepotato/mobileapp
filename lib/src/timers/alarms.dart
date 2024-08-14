import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;
import '../timers/feed_timer.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlarmPage extends StatefulWidget 
{
   const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}


//allows user to create alarms
class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Timers'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          //display alarms
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('Alarms')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No alarms yet!'),
                );
              }
              return Column(
                children: snapshot.data!.docs.map((alarmDoc) {
                  final alarmData = alarmDoc.data() as Map<String, dynamic>;
                  final hour = alarmData['hour'];
                  final minutes = alarmData['minutes'];
                  final clock = alarmData['clock'];
                  return ListTile(
                  title: Text(alarmData['reason']),
                  subtitle: Text('Time: $hour:$minutes $clock'),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TimerPage()),
          );
        },
        label: const Text('Create an Alarm'),
        icon: const Icon(Icons.add_alarm),
      ),
    );
  }
}