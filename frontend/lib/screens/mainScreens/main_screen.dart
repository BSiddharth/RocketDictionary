import 'package:flutter/material.dart';
import 'package:rocketdictionary/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rocketdictionary/customWidgets/drawer_switch.dart';
import 'package:rocketdictionary/customWidgets/follow_links_and_copyright.dart';
import 'package:rocketdictionary/providers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocketdictionary/screens/mainScreens/bookmarks_screen.dart';
import 'package:rocketdictionary/screens/mainScreens/glossary_screen.dart';
import 'package:rocketdictionary/screens/mainScreens/home_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const name = '/';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
  void initState() {
    super.initState();
    ref.read(rocketListNotifierProvider.notifier).getRocketList();
    ref.read(glossaryListNotifierProvider.notifier).getGlossaryList();
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
