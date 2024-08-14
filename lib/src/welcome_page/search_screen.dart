import 'package:flutter/material.dart';
import 'package:hop_app/src/articles/articles_main_page.dart';
import '../timers/alarms.dart';
import '../emergency/checklist.dart';
import '../bunny_care/bunny_items.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> data = [
    'Article',
    'Bunny Care',
    'Emergency Checklist',
    'Feed Timer',
  ];

  List<String> searchResults = [];

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

//takes user to specified page upon tap  
  void navigateToDetailPage(String selectedItem) {
    switch (selectedItem) {
    case 'Article':
    
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ArticlePage()),
      );
      break;
    case 'Bunny Care':
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ItemsPage()),
      );
      break;
    case 'Emergency Checklist':
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChecklistPage()),
      );
      break;
    case 'Feed Timer':
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlarmPage()),
      );
      break;
    default:
      // Handle cases where selectedItem does not match any known item
      print('Detail page not found for item: $selectedItem');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hop Fast Search'),
      ),
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // Navigate to detail page when the item is tapped
                  onTap: () {
                    navigateToDetailPage(searchResults[index]);
                  },
                  title: Text(searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final void Function(String) onQueryChanged;

  const SearchBar({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
