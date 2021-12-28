import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class GlossaryScreen extends StatelessWidget {
  GlossaryScreen({Key? key}) : super(key: key);
  // final ScrollController _firstController = ScrollController();
  final List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

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
          return const Center(
            child: Text('Loaded'),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
    // ScrollGlowRemover(
    //   child: Scrollbar(
    //     // controller: _firstController,
    //     child: ListView.builder(
    //       itemCount: 26,
    //       itemBuilder: (context, index) {
    //         return StickyHeader(
    //           header: Heading(
    //             heading: alphabets[index],
    //           ),
    //           content: Column(
    //             children: const [
    //               CollapsibleGlossaryCard(),
    //               CollapsibleGlossaryCard(),
    //               CollapsibleGlossaryCard(),
    //               CollapsibleGlossaryCard(),
    //               CollapsibleGlossaryCard(),
    //               CollapsibleGlossaryCard(),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    //   // (
    //   // controller: _firstController,
    //   // children: const [
    //   //   Heading(heading: 'A'),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   Heading(heading: 'B'),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   //   CollapsibleGlossaryCard(),
    //   // ],
    //   // ),
    //   // ),
    // );
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
  const CollapsibleGlossaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 5.0,
      ),
      child: Card(
        // color: kDarkModeSupportBlackishGrey,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          title: Text('ExpansionTile 1'),
          subtitle: Text('Trailing expansion arrow icon'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 1')),
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
  final List glossaryList;
  const GlossaryListLoadedState({required this.glossaryList});
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is GlossaryListLoadedState && o.glossaryList == glossaryList;
  }

  @override
  int get hashCode => glossaryList.hashCode;
}

class GlossaryListErrorState extends GlossaryListState {
  const GlossaryListErrorState();
}

class GlossaryListStateNotifier extends StateNotifier<GlossaryListState> {
  GlossaryListStateNotifier() : super(const GlossaryListLoadingState());

  Future<void> getGlossaryList() async {
    try {
      state = const GlossaryListLoadingState();
      // get list here
    } catch (e) {
      print('e');
      state = const GlossaryListErrorState();
    }
  }
}

final glossaryListNotifierProvider = StateNotifierProvider((ref) {
  return GlossaryListStateNotifier();
});
