// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;
import 'package:url_launcher/url_launcher.dart';

class HousingPage extends StatefulWidget 
{
   const HousingPage({super.key});

  @override
  State<HousingPage> createState() => _HousingPageState();
}



class _HousingPageState extends State<HousingPage> {
 final List<Map<String, String>> housingItems = [
    {'name': 'Cages', 'url': 'https://www.amazon.com/dp/B0133LNLJY?tag=thesprucepets-onsite-prod-20&ascsubtag=4772647%7Cn9b7338c2893642e5953279c03fbd301203%7C'},
    {'name': 'Litter-box', 'url': 'https://www.amazon.com/Tfwadmx-Trainer-Chinchilla-Hamster-Hedgehog/dp/B0BC7473NF/ref=asc_df_B0BC7473NF/?tag=hyprod-20&linkCode=df0&hvadid=680368675873&hvpos=&hvnetw=g&hvrand=17935426184767910899&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9028174&hvtargid=pla-2289337168234&psc=1&mcid=540bb234f151354ca003b916c8cdbdb0&gad_source=1'},
    {'name': 'Pellet bowl', 'url': 'http://www.therabbithouse.com/equipment/rabbit-food-bowl.asp'},
    {'name': 'Water bottle', 'url': 'https://www.allthingsbunnies.com/Lixit-Weather-Resistant-Water-Bottles-p/wb121.htm'},
    {'name': 'Toys', 'url': 'https://www.chewy.com/oxbow-enriched-life-play-wall-small/dp/226876?utm_source=partnerize&utm_medium=affiliates&utm_campaign=1011l10259&utm_content=0&clickref=1101lyoDGVrb&utm_term=1101lyoDGVrb'},
    {'name': 'Animal Carrier', 'url': 'https://www.amazon.com/Sleepypod-Medium-Mobile-Pet-Black/dp/B000SICUE8?dchild=1&keywords=sleepypod%2Bmobile%2Bpet%2Bbed&qid=1617023686&s=pet-supplies&sr=1-4&th=1&linkCode=sl1&tag=thebunnylady-20&linkId=be9cab84187c1a1674d3d6ee15a8e427&language=en_US&ref_=as_li_ss_tl'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Housing Items'),
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
        children: List.generate(housingItems.length, (index) {
          final item = housingItems[index];
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