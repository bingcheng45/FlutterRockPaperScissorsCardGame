import 'package:flutter/material.dart';
import 'package:rps_card_game/lobbyPage.dart';

class LoginPage extends StatelessWidget {
  final String url;
  LoginPage(this.url);

  final TextEditingController controller = TextEditingController();

  void goToLobbyPage(String myNickname, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LobbyPage(url: url, myNickname: myNickname,)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Nickname"),
              onSubmitted: (myNickname) => goToLobbyPage(myNickname, context),
            ),
            FlatButton(
                onPressed: () => goToLobbyPage(controller.text, context),
                child: Text("Log In"))
          ],
        ),
      ));
}
