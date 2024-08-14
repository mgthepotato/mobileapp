import 'package:flutter/material.dart';
import '../emergency/gistasis.dart';
import '../emergency/vet.dart';
import '../emergency/fine.dart';
import '../global_features/hamburger_menu.dart';
import 'package:hop_app/src/articles/gi_stasis_symptoms/diarehea.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  Map<String, bool> items = {
    'Decreased or no appetite': false,
    'Reduced or no fecal output': false,
    'Grinding teeth/bruxism': false,
    'Bloating': false,
    'Diarrhea': false,
    'Hunched posture': false,
    'Low body temperature': false,
    'Abdominal pain when touched': false,
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GI Stasis Checklist'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: items.keys.map((String item) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item),
                    IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        if(item == 'Diarrhea'){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DiareheaPage()),
                          );
                        }


                      },
                    ),
                  ],
                ),
                value: items[item]!,
                onChanged: (bool? value) {
                  setState(() {
                    items[item] = value!;
                  });
                },
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              //conditionals for checklist
              bool decreasedAppetiteChecked = items['Decreased or no appetite'] ?? false;
              bool noFecalOutputChecked = items['Reduced or no fecal output'] ?? false;
              
              int checkedCount = items.values.where((element) => element).length;
              
              if ((decreasedAppetiteChecked && noFecalOutputChecked) ) 
              {
                if (checkedCount >= items.length / 2) 
                {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StasisPage()),
                  );
                }
                else 
                {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VetPage()),
                  );
                }
              }

           else {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OkPage()),
                  );
              }
            },
            child: const Text('Check'),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
