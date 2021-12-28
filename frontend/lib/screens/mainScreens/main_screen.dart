import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocketdictionary/screens/mainScreens/bookmarks_screen.dart';
import 'package:rocketdictionary/screens/mainScreens/glossary_screen.dart';
import 'package:rocketdictionary/screens/mainScreens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const name = '/';

  @override
  State<MainScreen> createState() => _MainPageState();
}

class _MainPageState extends State<MainScreen> {
  static int _selectedIndex = 0;

  static final List<Widget> _screenList = <Widget>[
    const HomeScreen(),
    const GlossaryScreen(),
    const BookmarksScreen(),
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
      appBar: AppBar(
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            return Image.asset(
              "assets/images/RocketDictionaryLogo-removebg.png",
              height: 45,
              color: ref.watch(lightModeActivatedStateProvider)
                  ? kPrussianBlue
                  : kAntiFlashWhite,
            );
          },
        ),
        leading: Builder(builder: (context) {
          // not using custom icon button because this is special case it needs the context from the builder and changing custom icon button for this not worth it.
          return IconButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu_rounded,
                size: 28,
              ));
        }),
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
          return Drawer(
            child: Column(
              children: [
                Container(
                  color: ref.watch(lightModeActivatedStateProvider)
                      ? Colors.grey
                      : kDarkModeSupportBlackishGrey,
                  height: 0.3 * dimension.height,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 0.05 * dimension.height,
                        child: const Text('SB'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Siddharth Bisht',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  color: ref.watch(lightModeActivatedStateProvider)
                      ? kAntiFlashWhite
                      : kDarkModeMainBlack,
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
      body: _screenList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
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
  Widget build(BuildContext context, WidgetRef ref) {
    final Color textColor = ref.watch(lightModeActivatedStateProvider)
        ? Colors.grey
        : kAntiFlashWhite;
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
            'Ⓒ 2021 RocketDictionary® v1.0.0',
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
