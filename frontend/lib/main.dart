import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:rocketdictionary/screens/card_detailed.dart';
import 'package:rocketdictionary/screens/mainScreens/main_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Rocket Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(lightModeActivatedStateProvider)
          ? lightThemeData
          : darkThemeData,
      initialRoute: '/',
      routes: {
        MainScreen.name: (context) => const MainScreen(),
        CardDetailed.name: (context) => CardDetailed(),
      },
    );
  }
}
