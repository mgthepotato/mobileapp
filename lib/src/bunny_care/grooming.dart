// ignore_for_file: deprecated_member_use
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../global_features/hamburger_menu.dart' ;

class GroomPage extends StatefulWidget 
{
   const GroomPage({super.key});

  @override
  State<GroomPage> createState() => _GroomPageState();
}



class _GroomPageState extends State<GroomPage> {
 final List<Map<String, String>> groomItems = [
    {'name': 'Flea Comb', 'url': 'https://www.chewy.com/master-grooming-tools-contoured-grip/dp/238642'},
    {'name': 'Brush', 'url': 'https://www.amazon.com/Small-Pet-Select-HairBuster-Comb/dp/B06ZZXF81G/ref=as_li_ss_tl?dchild=1&keywords=small+pet+select+fur+buster&qid=1598220588&sr=8-4&linkCode=sl1&tag=thebunnylady-20&linkId=3c9b5c781aa1f3a247390ebe2afe9b5e&language=en_US'},
    {'name': 'Nail clippers', 'url': 'https://www.amazon.com/Candure-Clippers-Hamsters-Trimming-Stainless/dp/B0C3QYHYLX/ref=sr_1_1_sspa?dib=eyJ2IjoiMSJ9.eCoZjZPPHcwuWb4xqLGsTyTdC1BmnhPgCOKOUJOu2zpj92NPu_Sd9hSm0vNK8PWz0r2IDhaiHnGe4kZolFU0UF7YZrRXVVR-6E-x_2wGPKEyYDqcSqPBSoB7wNxRhwVjLedK8PwE1XRd9i7GIlrQnoIo75q1YMMzLq4Q5ZL6-bzKp-zZw65Bujah4qw2WC2uk2kTKTtDgWmEdVMS7P7KZqbtjgFfPKAlSALWWx3RD6tSeLujalNNAKwyXtnU-X95hoL-9RQCaKNo_b2JgoDsTJLgoj0V-jry1lUZtZoRXyU.yvnKUY5FC5nfngbYKXaa7Rg0z49NqTU_eI3-7gwi1IM&dib_tag=se&keywords=rabbit+nail+clippers&qid=1711298906&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Grooming Items'),
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
        children: List.generate(groomItems.length, (index) {
          final item = groomItems[index];
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