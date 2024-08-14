// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class SpacePage extends StatefulWidget 
{
   const SpacePage({super.key});

  @override
  State<SpacePage> createState() => _SpacePageState();
}



class _SpacePageState extends State<SpacePage> {
 final List<Map<String, String>> insideItems = [
    {'name': 'Bunny-proof room', 'url': 'https://www.amazon.com/AmazonBasics-Foldable-Metal-Exercise-Fence/dp/B0758FX7MJ/ref=as_li_ss_tl?th=1&linkCode=sl1&tag=thebunnylady-20&linkId=84537f212d8579cadebbbb785603f545&language=en_US'},
    {'name': 'Litter-box', 'url': 'https://www.petco.com/shop/en/petcostore/product/arm-and-hammer-large-rimmed-litter-pan?irgwc=1&irclickid=wNtT7jXYhxyPUB50waSzjUx-UkHUPXWHxyw%3AQo0&cm_mmc=AFF%7CIMP%7CCCY%7CCCO%7CPM%7C0%7CrBfYNcTb52ivxnPcri3CBm%7C2402433%7C648966%7C0%7C0'},
    {'name': 'Chew Toys', 'url': 'https://store.binkybunny.com/products/cottontail-cottage?_pos=1&_sid=76c6303ca&_ss=r'},
    {'name': 'Dig Toys', 'url': 'https://www.amazon.com/gp/product/B0009YD810?ie=UTF8&tag=anifacgui-20&link_code=wql'},

  ];
   final List<Map<String, String>> outsideItems = [
    {'name': 'Fenced patio/porch/playpen (with floors)', 'url': 'https://www.amazon.com/dp/B000V6C7DQ?tag=track-ect-usa-973100-20&linkCode=osi&th=1&psc=1'},
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Items'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Outside Items(supervised at all times):',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              children: List.generate(outsideItems.length, (index) {
                final item = outsideItems[index];
                return GestureDetector(
                  onTap: () {
                    _launchURL(item['url']!);
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        item['name']!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Inside Items:',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true, //so the whole page scrolls and not just each section
              physics:const NeverScrollableScrollPhysics(),
              children: List.generate(insideItems.length, (index) {
                final item = insideItems[index];
                return GestureDetector(
                  onTap: () {
                    _launchURL(item['url']!);
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        item['name']!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
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