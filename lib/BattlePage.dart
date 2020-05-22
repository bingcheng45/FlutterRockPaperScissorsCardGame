import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';

class BattlePage extends StatefulWidget {
  final String myNickname;
  final String url;

  BattlePage({this.myNickname, this.url});

  @override
  _BattlePageState createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
  bool opponentFound = false;
  String servermsg = "";

  SocketIO socketIO;
  void _connectSocket01() {
    //update your domain before using
    socketIO = SocketIOManager().createSocketIO(
        "http://192.168.1.110:3000", "/",
        query: "userId=1234", socketStatusCallback: _socketStatus);

    //call init socket before doing anything
    socketIO.init();

    

    //subscribe event
    // socketIO.subscribe("receive_message", (data) {
    //   print('opponent found!');
    //   setState(() {
    //     opponentFound = true;
    //   });
    // });

    //subscribe event
    socketIO.subscribe("test", (msg) {
      print('server got message!');
      setState(() {
        opponentFound = true;
        servermsg = msg;
      });
    });

    //connect socket
    socketIO.connect();
    socketIO.sendMessage('adduser', 'test name');
    print('connecting to server');
  }

  void _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  // _subscribes() {
  //   if (socketIO != null) {
  //     socketIO.subscribe("chat_direct", _onReceiveChatMessage);
  //   }
  // }

  // void _onReceiveChatMessage(dynamic message) {
  //   print("Message from UFO: " + message);
  // }

  // void _sendChatMessage(String msg) async {
  //   if (socketIO != null) {
  //     String jsonData =
  //         '{"message":{"type":"Text","content": ${(msg != null && msg.isNotEmpty) ? '"${msg}"' : '"Hello SOCKET IO PLUGIN :))"'},"owner":"589f10b9bbcd694aa570988d","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
  //     socketIO.sendMessage("chat_direct", jsonData, _onReceiveChatMessage);
  //   }
  // }

  void _destroySocket() {
    if (socketIO != null) {
      SocketIOManager().destroySocket(socketIO);
    }
  }

  void _sendmsg() {
    socketIO.sendMessage('send_message', json.encode({'test': 'hahaha'}));
  }

  void _matchmake(String roomName){
    //socketIO.
  }

  @override
  void initState() {
    super.initState();
    _connectSocket01();

    //_sendmsg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (opponentFound)
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.orangeAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('SERVER MESSAGE: ' + servermsg),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(child: Text('Room 1')),
                      ),
                      onPressed: () {

                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(child: Text('Room 2')),
                      ),
                      onPressed: () {},
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(child: Text('Room 3')),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            : Container(
                child: Text('Matchmaking...'),
              ),
      ),
    );
  }
}
