import 'package:flutter/material.dart';
import 'package:rps_card_game/BattlePage.dart';

class LobbyPage extends StatefulWidget {
  final String myNickname;
  final String url;
  LobbyPage({this.myNickname, this.url});

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;


    void goToBattlePage(String url, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BattlePage(myNickname: widget.myNickname, url: url,)));
  }

    Widget matchMakingButton(
        {Color bgColor, Color splashColor, String text, Function onpressed}) {
      return Container(
        height: screenHeight * 0.2,
        width: screenHeight * 0.2,
        child: FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          color: bgColor,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          splashColor: splashColor,
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(fontSize: 30),
            ),
          ),
          onPressed: onpressed,
        ),
      );
    }

    Widget lobbyLayout() {
      return Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                matchMakingButton(
                    bgColor: Colors.blue[400],
                    splashColor: Colors.blueAccent,
                    text: 'Casual',
                    onpressed: () => goToBattlePage(widget.url , context)),
                matchMakingButton(
                    bgColor: Colors.red[400],
                    splashColor: Colors.redAccent,
                    text: 'Ranked',
                    onpressed: () {}),
              ],
            ),
            matchMakingButton(
                bgColor: Colors.greenAccent[400],
                splashColor: Colors.greenAccent,
                text: 'Private',
                onpressed: () {}),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('I am an app bar'),
        ),
        body: lobbyLayout(),
      ),
    );
  }
}
