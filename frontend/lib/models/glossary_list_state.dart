import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rocketdictionary/apiServices/get_glossary_list.dart';
import 'package:rocketdictionary/models/glossary_word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  // GlossaryListStateNotifier() : super(const GlossaryListErrorState());
  // GlossaryListStateNotifier() : super(const GlossaryListLoadedState());
  GlossaryListStateNotifier() : super(const GlossaryListLoadingState());

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
