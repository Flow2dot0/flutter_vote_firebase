import 'package:flutter/material.dart';
import 'package:flutter_vote_firebase/constants.dart';
import 'package:flutter_vote_firebase/screens/home_screen.dart';
import 'package:flutter_vote_firebase/screens/launch_screen.dart';
import 'package:flutter_vote_firebase/screens/result_screen.dart';
import 'package:flutter_vote_firebase/state/vote.dart';
import 'package:provider/provider.dart';

void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VoteState(),
        )
      ],
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => Scaffold(
                body: LaunchScreen(),
              ),
          "/home": (context) => Scaffold(
                appBar: AppBar(
                  title: Text(kAppName),
                ),
                body: HomeScreen(),
              ),
          "/result": (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Result'),
                  leading: IconButton(
                      icon: Icon(Icons.home),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                  ),
                ),
                body: ResultScreen(),
              )
        },
      ),
    );
  }
}
