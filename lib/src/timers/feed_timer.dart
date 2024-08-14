import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;
import '../timers/alarms.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TimerPage extends StatefulWidget 
{
   const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}



class _TimerPageState extends State<TimerPage> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String selectedClock = 'AM'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Timer'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: TextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: TextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: selectedClock,
                  onChanged: (value) {
                    setState(() {
                      selectedClock = value!;
                    });
                  },
                  items: <String>['AM', 'PM'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int hour = int.parse(hourController.text);
                int minutes = int.parse(minuteController.text);

                //Adjust hour based on AM or PM selection
                if (selectedClock == 'PM' && hour < 12) {
                  hour += 12;
                } else if (selectedClock == 'AM' && hour == 12) {
                  hour = 0;
                }

                //Save the alarm data to Firestore
                saveAlarmToFirestore(ScaffoldMessenger.of(context), hour, minutes, reasonController.text);
              },
              child: const Text('Create Alarm'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AlarmPage()),
          );
        },
        label: const Text('Show Alarms'),
        icon: const Icon(Icons.access_alarm),
      ),
    );
  }

//to avoid using builder context
  Future<void> saveAlarmToFirestore(ScaffoldMessengerState scaffoldMessenger, int hour, int minutes, String reason) async {
    try {
      //get users userid
      String userId = FirebaseAuth.instance.currentUser!.uid;

      //to get to users alarm collection
      CollectionReference alarmsCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Alarms');

      // add new alarm data
      await alarmsCollection.add({
        'hour': hour,
        'minutes': minutes,
        'clock': selectedClock,
        'reason': reason,
      });

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Alarm created successfully'),
        ),
      );
    } catch (error) {
      // for errors
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to create alarm: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}