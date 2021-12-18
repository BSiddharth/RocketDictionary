import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocketdictionary/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: kDarkModeMainBlack,
  // ));
  
  runApp(const ProviderScope(child: MyApp()));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

final lightModeActivatedStateProvider = StateProvider<bool>((ref) => true);

// final lightModeActivatedProvider = Provider<bool>((ref) => false);

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
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: kAntiFlashWhite);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Rocket',
      style: optionStyle,
    ),
    Text(
      'Index 1: Glossary',
      style: optionStyle,
    ),
    Text(
      'Index 2: Bookmarks',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            return Image.asset(
          "assets/images/RocketDictionaryLogo-removebg.png",
          height: 45,
          color: ref.watch(lightModeActivatedStateProvider)? kPrussianBlue:kAntiFlashWhite,
        ) ;
          },
        ),
        leading: IconButton(
          color: Theme.of(context).iconTheme.color,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu_rounded,
              size: 28,
            )),
        // leading: const Icon(
        //       Icons.menu_rounded,
        //       size: 28,
        //       // color: kPrussianBlue,
        //     ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
            iconSize: 28,
            color: kDarkModeGreen,
          ),
          Consumer(builder: (context, ref, child) {
            final color = ref.watch(lightModeActivatedStateProvider)
                ? kCerulean
                : kDeepSkyBlue;
            return IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 28,
              color: color,
            );
          }),
        ],
      ),
      drawer: Consumer(
        builder: (context, ref, child) {
          return  Drawer(
        child: Column(
          children: [
            Container(
              color: ref.watch(lightModeActivatedStateProvider)? Colors.grey: kDarkModeSupportBlackishGrey,
              height: 0.3 * dimension.height,
              // height: 0.3 * dimension.height,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              color: ref.watch(lightModeActivatedStateProvider)? kAntiFlashWhite: kDarkModeMainBlack,
              child: Column(
                children: const [
                  DrawerSwitch(),
                  Spacer(),
                  FollowLinksAndCopyRight(),
                ],
              ),
            ))
          ],
        ),
      );
        },
      ),
      
     
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: Image.asset(
            //   'assets/icons/rocket.png',
            //   color: _selectedIndex == 0 ? kDeepSkyBlue : kAntiFlashWhite,
            //   height: 25,
            // ),
            icon: FaIcon(FontAwesomeIcons.rocket),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Glossary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: kDeepSkyBlue,
        // selectedItemColor: kCerulean,
        // unselectedItemColor: kAntiFlashWhite,
        onTap: _onItemTapped,
        // backgroundColor: kDarkModeSupportBlackishGrey,
      ),
    );
  }
}

class DrawerSwitch extends ConsumerWidget {
  const DrawerSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool switchValue = !ref.watch(lightModeActivatedStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.orange,
            size: 34,
          ),
          const SizedBox(
            width: 7,
          ),
          Transform.scale(
            scale: 1.1,
            child: Switch(
              value: switchValue,
              onChanged: (val) {
                ref.read(lightModeActivatedStateProvider.state).state = !val;
              },
              activeColor: kCornFlowerBlue,
              inactiveThumbColor: Colors.orange,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          const Icon(
            Icons.nightlight_outlined,
            color: kCornFlowerBlue,
            size: 34,
          )
        ],
      ),
    );
  }
}

class FollowLinksAndCopyRight extends ConsumerWidget {
  const FollowLinksAndCopyRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final Color textColor = ref.watch(lightModeActivatedStateProvider)? Colors.grey: kAntiFlashWhite;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
           Text(
            'Follow us on',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              FaIcon(FontAwesomeIcons.facebookF),
              FaIcon(FontAwesomeIcons.twitter),
              FaIcon(FontAwesomeIcons.instagram),
              FaIcon(FontAwesomeIcons.linkedinIn),
              FaIcon(FontAwesomeIcons.telegram),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
           Text(
            'Ⓒ 2021 RocketDictionary® v0.0.10',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
