import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'iconbutton.dart';
import 'cards.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kings',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with 'flutter run'. You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // 'hot reload' (press 'r' in the console where you ran 'flutter run',
        // or simply save your changes to 'hot reload' in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
        backgroundColor: Colors.black,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Kings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked 'final'.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Game game = Game();
  @override
  void initState() {
    super.initState();
    game.resetGame();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //
  //   for (var card in game.allCards) {
  //     precacheImage(AssetImage('assets/$card'), context);
  //   }
  // }
  void _openURL(String uri) async {
    var url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(200, 0, 0, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text(
                  'itsscb',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  'dev@itsscb.de',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/icon.png'),
                    )
                ),
              ),
              ListTile(
                leading: const Icon(
                    Icons.play_arrow,
                color: Colors.white,),
                title: const Text(
                  'New Game',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                onTap: () => {
                  setState(() {
                    game.resetGame();
                    scaffoldKey.currentState?.closeDrawer();
                  }),
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                title: const Text(
                  "Send Mail",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () => {
                  _openURL('mailto:dev@itsscb.de?subject=Kings%3A%20Feedback%0A')
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Image.asset('assets/icon.png'),
          actions: [
            IconButton(onPressed: () => {
              setState(() {
                scaffoldKey.currentState?.openDrawer();
              }),
            }, icon: const Icon(Icons.menu)
            ),
          ],
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SafeArea(
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke 'debug painting' (press 'p' in the console, choose the
              // 'Toggle Debug Paint' action from the Flutter Inspector in Android
              // Studio, or the 'Toggle Debug Paint' command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: Text(game.getText(),
                        style: const TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: const Text(
                            'Active Rules:',
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                          CircleAvatar(
                            child: Text(game.ruleCount.toString()),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                flex: 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      game.nextCard();
                    });
                  },
                  child: Image.asset(
                    'assets/images/${game.currCard.path}',
                    fit: BoxFit.contain,
                  ),
                ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: const Text(
                            'Active Rules:',
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          child: Text(game.ruleCount.toString()),
                        ),

                      ],
                    ),
                    Text(game.getText(),
                      style: const TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.black,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icoBtn(
                    Icons.arrow_back_ios_new, () {
                  setState(() {
                    game.prevCard();
                  });
                },
                  game.playedCards.isNotEmpty && game.counter > 0,
                ),
                const SizedBox(
                  height: 100,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    width: 10,
                  ),
                ),
                icoBtn(
                    Icons.arrow_forward_ios, () {
                  setState(() {
                    game.nextCard();
                  });
                },
                    game.availableCards.isNotEmpty || game.counter < game.availableCards.length),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
