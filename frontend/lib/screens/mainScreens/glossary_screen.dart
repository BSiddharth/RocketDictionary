import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/collapsible_glossary_card.dart';
import 'package:rocketdictionary/customWidgets/heading.dart';
import 'package:rocketdictionary/customWidgets/rocket_loading.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/models/glossary_list_state.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlossaryScreen extends StatelessWidget {
  GlossaryScreen({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final glossaryListState = ref.watch(glossaryListNotifierProvider);
        if (glossaryListState is GlossaryListLoadingState) {
          return const Center(child: RocketLoading());
        } else if (glossaryListState is GlossaryListLoadedState) {
          final glossaryMap = glossaryListState.glossaryMap;
          final glossaryMapKeys = glossaryMap.keys.toList();
          return ScrollGlowRemover(
            child: Scrollbar(
              child: RefreshIndicator(
                onRefresh: ref
                    .read(glossaryListNotifierProvider.notifier)
                    .getGlossaryList,
                child: ListView.builder(
                  controller: _scrollController,
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
                  onPressed: ref
                      .read(glossaryListNotifierProvider.notifier)
                      .getGlossaryList,
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
