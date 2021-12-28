import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rocketdictionary/apiServices/get_glossary_list.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/models/glossary_word.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class GlossaryScreen extends StatelessWidget {
  const GlossaryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final glossaryListState = ref.watch(glossaryListNotifierProvider);
        if (glossaryListState is GlossaryListLoadingState) {
          return Center(
            child: Lottie.asset(
              'assets/animation/rocketLoading.json',
              width: 400,
              height: 400,
              fit: BoxFit.fill,
            ),
          );
        } else if (glossaryListState is GlossaryListLoadedState) {
          final glossaryMap = glossaryListState.glossaryMap;
          final glossaryMapKeys = glossaryMap.keys.toList();
          return ScrollGlowRemover(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: glossaryMap.length,
                itemBuilder: (context, index) {
                  final heading = glossaryMapKeys[index];
                  final childrenList = glossaryMap[heading]
                      .map<Widget>((ele) => CollapsibleGlossaryCard(
                            name: ele.name,
                            description: ele.description,
                          ))
                      .toList();
                  return StickyHeader(
                    header: Heading(
                      heading: heading,
                    ),
                    content: Column(
                      children: childrenList,
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Something is not right',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                    ref
                        .read(glossaryListNotifierProvider.notifier)
                        .getGlossaryList();
                    // final http.Response response =
                    //     await backendGetGlossaryList();
                    // final workingList = jsonDecode(response.body);
                    // var glossaryMap = {};
                    // // GlossaryWord glossaryWord;
                    // workingList.forEach((value) {
                    //   final glossaryWord = GlossaryWord(
                    //       name: value['name'],
                    //       description: value['description']);
                    //   final startingAlphabet =
                    //       glossaryWord.name[0].toUpperCase();
                    //   if (glossaryMap.containsKey(startingAlphabet)) {
                    //     glossaryMap[startingAlphabet].add(glossaryWord);
                    //   } else {
                    //     glossaryMap[startingAlphabet] = [];
                    //   }
                    // });
                    // print(glossaryMap);
                  },
                  child: const Text('Reload'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.heading}) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(fontSize: 18),
            ),
            Container(
              color: Colors.grey,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class CollapsibleGlossaryCard extends StatelessWidget {
  final String name;
  final String description;
  const CollapsibleGlossaryCard(
      {Key? key, required this.name, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 5.0,
      ),
      child: Card(
        // color: kDarkModeSupportBlackishGrey,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          textColor: Theme.of(context).textTheme.bodyText1!.color,
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          title: Text(name),
          children: <Widget>[
            ListTile(title: Text(description)),
          ],
        ),
      ),
    );
  }
}

abstract class GlossaryListState {
  const GlossaryListState();
}

class GlossaryListLoadingState extends GlossaryListState {
  const GlossaryListLoadingState();
}

class GlossaryListLoadedState extends GlossaryListState {
  final Map glossaryMap;
  const GlossaryListLoadedState({required this.glossaryMap});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlossaryListLoadedState && other.glossaryMap == glossaryMap;
  }

  @override
  int get hashCode => glossaryMap.hashCode;
}

class GlossaryListErrorState extends GlossaryListState {
  const GlossaryListErrorState();
}

class GlossaryListStateNotifier extends StateNotifier<GlossaryListState> {
  GlossaryListStateNotifier() : super(const GlossaryListErrorState());
  // GlossaryListStateNotifier() : super(const GlossaryListLoadedState());
  // GlossaryListStateNotifier() : super(const GlossaryListLoadingState());

  Future<void> getGlossaryList() async {
    try {
      state = const GlossaryListLoadingState();
      final http.Response response = await backendGetGlossaryList();
      final workingList = jsonDecode(response.body);
      var glossaryMap = {};
      // GlossaryWord glossaryWord;
      workingList.forEach((value) {
        final glossaryWord = GlossaryWord(
            name: value['name'], description: value['description']);
        final startingAlphabet = glossaryWord.name[0].toUpperCase();
        if (glossaryMap.containsKey(startingAlphabet)) {
          glossaryMap[startingAlphabet].add(glossaryWord);
        } else {
          glossaryMap[startingAlphabet] = [glossaryWord];
        }
      });
      state = GlossaryListLoadedState(glossaryMap: glossaryMap);

      // get list here
    } catch (e) {
      state = const GlossaryListErrorState();
    }
  }
}

final glossaryListNotifierProvider = StateNotifierProvider((ref) {
  return GlossaryListStateNotifier();
});
