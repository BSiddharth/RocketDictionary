import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/models/rocket.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:rocketdictionary/screens/card_detailed.dart';
import 'package:rocketdictionary/screens/mainScreens/main_screen.dart';
import 'package:rocketdictionary/screens/search_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RocketAdapter());
  await Hive.openBox('bookMarks');

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
        SearchPage.name: (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CardDetailed.name) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as Map;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return CardDetailed(
                summary: args['summary'],
                rocketName: args['rocketName'],
                content: args['content'],
                images: args['images'],
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
