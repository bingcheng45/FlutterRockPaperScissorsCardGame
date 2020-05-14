import 'package:flutter/material.dart';

class BattlePage extends StatefulWidget {
  final String myNickname;
  final String url;

  BattlePage({this.myNickname, this.url});

  @override
  _BattlePageState createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  bool opponentFound = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (opponentFound)
        ? Container(
            child: Text('opponent found baby'),
          )
        : Container(
            child: Text('Matchmaking...'),
          ),
      ),
    );
  }
}
