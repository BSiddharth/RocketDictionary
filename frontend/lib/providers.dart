import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/models/glossary_list_state.dart';
import 'package:rocketdictionary/models/rocket_list_state.dart';

// provides light mode state
final lightModeActivatedStateProvider = StateProvider<bool>((ref) => false);

// provides GlossaryListStateNotifier
final glossaryListNotifierProvider = StateNotifierProvider((ref) {
  return GlossaryListStateNotifier();
});

// provides RocketListStateNotifier
final rocketListNotifierProvider = StateNotifierProvider((ref) {
  return RocketListStateNotifier();
});
