import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocketdictionary/const.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kDarkModeMainBlack,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kDarkModeMainBlack,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: kDarkModeMainBlack,elevation: 0,),
        iconTheme: const IconThemeData(size: 28,color: kAntiFlashWhite)
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/RocketDictionaryLogo-removebg.png",height: 45,),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon:const Icon(Icons.menu_rounded,size: 28,)
        ),
        actions: const [Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.filter_list_rounded),
        ),Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.search),
        ),],

        actionsIconTheme: const IconThemeData(size: 28,color: kAntiFlashWhite),
        
      ),
      drawer: const Drawer(),
       body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
        selectedItemColor: kAntiFlashWhite,
        onTap: _onItemTapped,
        backgroundColor: kDarkModeSupportBlackishGrey,
      ),
   
    );
  }
}