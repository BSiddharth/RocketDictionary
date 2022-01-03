import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rocketdictionary/customWidgets/custom_icon_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/rocket_card.dart';
import 'package:rocketdictionary/providers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const name = './SearchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CustomIconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          title: TextField(
            onChanged: (String value) {
              setState(() {
                searchString = value.toUpperCase();
              });
            },
            style: const TextStyle(fontSize: 18),
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Type in the rocket name', border: InputBorder.none),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final retrievedList =
                ref.read(retrievalProvider).find(searchString);
            if (searchString == '' || retrievedList.isEmpty) {
              return Center(
                child: Lottie.asset('assets/animation/bookmarksEmpty.json'),
              );
            } else {
              return ListView.builder(
                  itemCount: retrievedList.length,
                  itemBuilder: (BuildContext context, int count) {
                    return RocketCard(
                        mainImageUrl: retrievedList[count].mainImageUrl!,
                        rocketName: retrievedList[count].rocketName!,
                        rocketManufacturerName:
                            retrievedList[count].rocketManufacturerName!,
                        rocketStatus: retrievedList[count].rocketStatus!,
                        countryImageUrl: retrievedList[count].countryImageUrl!,
                        rocketType: retrievedList[count].rocketType!,
                        rocketCPL: retrievedList[count].rocketCPL!,
                        summary: retrievedList[count].summary!,
                        id: retrievedList[count].id,
                        content: retrievedList[count].content,
                        images: retrievedList[count].images,
                        isBookmarked: retrievedList[count].isBookmarked);
                  });
            }
          },
        ));
  }
}
