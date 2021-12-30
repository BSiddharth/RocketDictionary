import 'package:flutter/material.dart';
import 'package:rocketdictionary/customWidgets/heading.dart';
import 'package:rocketdictionary/customWidgets/rocket_card.dart';
import 'package:rocketdictionary/customWidgets/rocket_loading.dart';
import 'package:rocketdictionary/customWidgets/scroll_glow_remover.dart';
import 'package:rocketdictionary/models/rocket_list_state.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final rocketListState = ref.watch(rocketListNotifierProvider);
        if (rocketListState is RocketListLoadingState) {
          return const Center(child: RocketLoading());
        } else if (rocketListState is RocketListLoadedState) {
          final rocketMap = rocketListState.rocketMap;
          final rocketMapKeys = rocketMap.keys.toList();
          return ScrollGlowRemover(
            child: Scrollbar(
              child: RefreshIndicator(
                onRefresh:
                    ref.read(rocketListNotifierProvider.notifier).getRocketList,
                child: ListView.builder(
                  itemCount: rocketMap.length,
                  itemBuilder: (context, index) {
                    final heading = rocketMapKeys[index];
                    final childrenList = rocketMap[heading]
                        .map<Widget>(
                          (ele) => RocketCard(
                              mainImageUrl: ele.mainImageUrl,
                              rocketName: ele.rocketName,
                              rocketManufacturerName:
                                  ele.rocketManufacturerName,
                              rocketStatus: ele.rocketStatus,
                              countryImageUrl: ele.countryImageUrl,
                              rocketType: ele.rocketType,
                              rocketCPL: ele.rocketCPL),
                        )
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
                      .read(rocketListNotifierProvider.notifier)
                      .getRocketList,
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
