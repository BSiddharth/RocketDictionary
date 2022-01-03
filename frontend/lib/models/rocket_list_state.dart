import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/apiServices/get_rocket_list.dart';
import 'package:rocketdictionary/const.dart';
import 'package:rocketdictionary/models/rocket.dart';
import 'package:rocketdictionary/providers.dart';

abstract class RocketListState {
  const RocketListState();
}

class RocketListLoadingState extends RocketListState {
  const RocketListLoadingState();
}

class RocketListLoadedState extends RocketListState {
  final Map rocketMap;
  const RocketListLoadedState({required this.rocketMap});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RocketListLoadedState && other.rocketMap == rocketMap;
  }

  @override
  int get hashCode => rocketMap.hashCode;
}

class RocketListErrorState extends RocketListState {
  const RocketListErrorState();
}

class RocketListStateNotifier extends StateNotifier<RocketListState> {
  // RocketListStateNotifier() : super(const RocketListErrorState());
  // RocketListStateNotifier() : super(const RocketListLoadedState());
  RocketListStateNotifier() : super(const RocketListLoadingState());
  var workingList = [];

  Future<void> getRocketList(ConsumerStatefulElement ref) async {
    try {
      state = const RocketListLoadingState();
      final http.Response response = await backendGetRocketList();
      workingList = jsonDecode(response.body);
      final bookmarks = Hive.box('bookMarks');
      workingList = workingList.map((value) {
        final rocket = Rocket(
          mainImageUrl: value['mainImage'] ??
              'https://www.pngkit.com/png/detail/24-246151_spacecraft-rocket-launch-space-launch-astronaut-cartoon-rockets.png',
          rocketName: value['name'] ?? "N/A",
          countryImageUrl: value['countryOfOrigin'] ?? "Earth",
          rocketCPL: value['costPerLaunch'] ?? "N/A",
          rocketManufacturerName: value['manufacturer'] ?? 'N/A',
          rocketStatus: value['status'] ?? 'N/A',
          rocketType: value['type'] ?? 'N/A',
          content: value['content'],
          summary: value['summary'] ?? '',
          images: value['images'],
          id: value['_id'],
          isBookmarked: bookmarks.containsKey(value['_id']),
        );
        ref
            .read(retrievalProvider)
            .insert(rocket.rocketName!.toUpperCase(), rocket);
        return rocket;
      }).toList();
      filterRocketList(kfilter.name);
    } catch (e) {
      state = const RocketListErrorState();
    }
  }

  void filterRocketList(kfilter filter) {
    var rocketMap = {};
    for (var rocket in workingList) {
      if (filter == kfilter.name) {
        final startingAlphabet = rocket.rocketName![0].toUpperCase();
        if (rocketMap.containsKey(startingAlphabet)) {
          rocketMap[startingAlphabet].add(rocket);
        } else {
          rocketMap[startingAlphabet] = [rocket];
        }
      } else if (filter == kfilter.manufacturer) {
        final manufacturerName = rocket.rocketManufacturerName!;
        if (rocketMap.containsKey(manufacturerName)) {
          rocketMap[manufacturerName].add(rocket);
        } else {
          rocketMap[manufacturerName] = [rocket];
        }
      } else if (filter == kfilter.status) {
        final rocketStatus = rocket.rocketStatus!;
        if (rocketMap.containsKey(rocketStatus)) {
          rocketMap[rocketStatus].add(rocket);
        } else {
          rocketMap[rocketStatus] = [rocket];
        }
      } else if (filter == kfilter.country) {
        final manufacturerName = rocket.rocketManufacturerName!;
        if (rocketMap.containsKey(manufacturerName)) {
          rocketMap[manufacturerName].add(rocket);
        } else {
          rocketMap[manufacturerName] = [rocket];
        }
      }
    }

    state = RocketListLoadedState(rocketMap: rocketMap);
  }
}
