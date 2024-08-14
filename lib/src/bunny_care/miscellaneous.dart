// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class RandomPage extends StatefulWidget 
{
   const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}



class _RandomPageState extends State<RandomPage> {
 final List<Map<String, String>> randomItems = [
    {'name': 'Aspen Shavings ', 'url': 'https://www.petsmart.com/small-pet/litter-and-bedding/litter-and-bedding/full-cheeksandtrade-small-pet-aspen-bedding-5319158.html?gclsrc=aw.ds&gad_source=1&gclid=Cj0KCQjwqpSwBhClARIsADlZ_Tl8SMQlOQe8V50srq5Spw3pL-W45cZMAUtgbH7ik_GSDbKA2gwn0l0aAlMbEALw_wcB'},
    {'name': 'Dustpan', 'url': 'https://www.amazon.com/UNMOT-Cleaner-Hamster-Chinchilla-Cleaning/dp/B091F1R2L5/ref=asc_df_B091F1R2L5/?tag=hyprod-20&linkCode=df0&hvadid=507718505027&hvpos=&hvnetw=g&hvrand=11113425771517456216&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9028174&hvtargid=pla-1349789504607&psc=1&mcid=0ebae4beecd134f48e68302f1d753635&gclid=Cj0KCQjwqpSwBhClARIsADlZ_TnrZfEAVxK86QqRoEL5bC_UcVthl18mr-dhYbOiRDJLVCK05guch5gaAgg2EALw_wcB'},
    {'name': 'White Vinegar', 'url': 'https://www.petsmart.com/cat/litter-and-waste-disposal/deodorizers-and-filters/aunt-fannies-cleaning-vinegar-spray-for-cats-5335965.html?gclsrc=aw.ds&gad_source=1&gclid=Cj0KCQjwqpSwBhClARIsADlZ_TlsBjPt8YgAvpGmCKDzUJUxhliISqMYelCpSlQNV2N6LmykSFtAMCoaAsqfEALw_wcB'},
    {'name': 'Hand Vacuum', 'url': 'https://www.amazon.com/WIOR-Cordless-Handheld-Lightweight-Rechargeable/dp/B0C7QFTF3H/ref=asc_df_B0C7QFTF3H/?tag=hyprod-20&linkCode=df0&hvadid=675763752479&hvpos=&hvnetw=g&hvrand=1141284093122347136&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9028174&hvtargid=pla-2244856786787&psc=1&mcid=d9972ce9a3863cba966b396e0693e3ac&gad_source=1'},
    {'name': 'Chlorine Bleach', 'url': 'https://www.amazon.com/Clorox-Healthcare-Bleach-Germicidal-Cleaner/dp/B000GULS3W/ref=asc_df_B000GULS3W/?tag=hyprod-20&linkCode=df0&hvadid=198085085693&hvpos=&hvnetw=g&hvrand=12262772583939464713&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9028174&hvtargid=pla-349037289254&psc=1&mcid=05aa3c42f09433be8fd9498c8e5d8e30&gclid=Cj0KCQjwqpSwBhClARIsADlZ_TkzjAVsbCUge7ytIlG7Re3kElnTFV-9CpR_Bmx4P2n2N9M4wEiZsFkaAqO_EALw_wcB'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Miscellaneous Items'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
drawer: const CustomDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(randomItems.length, (index) {
          final item = randomItems[index];
          return GestureDetector(
            onTap: () {
              _launchURL(item['url']!);
            },
            child: Card(
              child: Center(
                child: Text(
                  item['name']!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}