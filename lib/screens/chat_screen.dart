import 'dart:io';

import 'package:demo_screen/bloc/chat_bloc.dart';
import 'package:demo_screen/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({@required this.groupName});
  final String groupName;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // bloc initialisation
  final ChatBloc _chatBloc = ChatBloc();
  final Color bgColor = Colors.black38;

  @override
  Widget build(BuildContext context) {
    final String groupName = widget.groupName;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColor,
          automaticallyImplyLeading: true,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  groupName[0],
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 25.0,
                      color: Colors.lightGreenAccent),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                groupName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<PopupMenuItem>(
              icon: FaIcon(
                FontAwesomeIcons.ellipsisV,
                color: Colors.green,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    enabled: false,
                    child: Row(
                      children: [],
                    ),
                  ),
                ];
              },
            ),
          ]),
      body: DefaultTabController(
        length: 2,
        child: StreamBuilder<ChatData>(
            stream: _chatBloc.chatStream,
            builder:
                (BuildContext context, AsyncSnapshot<ChatData> chatSnapshot) {
              if (chatSnapshot.hasData) {
                List<Map<String, String>> sentMessages =
                    chatSnapshot.data.sentMessages;
                List<Map<String, String>> receivedMessages =
                    chatSnapshot.data.receivedMessages;
                return Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 150.0),
                      child: Material(
                        color: Colors.black,
                        child: TabBar(
                          indicatorColor: Colors.white,
                          physics: NeverScrollableScrollPhysics(),
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    angle: 22 / 7,
                                    child: FaIcon(FontAwesomeIcons.share),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text("RECEIVED"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(FontAwesomeIcons.share),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text("SENT"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10.0,
                                      bottom: 5.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10.0,
                                              top: 15.0,
                                              right: 25.0,
                                              bottom: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.grey[850],
                                          ),
                                          child: Text(
                                            receivedMessages[i]['message'],
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 17.0,
                                            ),
                                          )),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Transform.rotate(
                                          angle: 22 / 7,
                                          child: FaIcon(
                                            FontAwesomeIcons.share,
                                            color: Colors.deepOrange,
                                            size: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount:
                                  chatSnapshot.data.receivedMessages.length,
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10.0,
                                      bottom: 5.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.grey[850],
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            text: sentMessages[i]['sender'],
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 17.0,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "\n\n${sentMessages[i]['message']}",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: FaIcon(
                                          FontAwesomeIcons.share,
                                          color: Colors.green,
                                          size: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: chatSnapshot.data.sentMessages.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator();
            }),
      ),
      /*body: StreamBuilder<ChatData>(
        stream: _chatBloc.chatStream,
        builder:
            (BuildContext context, AsyncSnapshot<ChatData> chatSnapshot) {
          if (chatSnapshot.hasData) {
            List<Map<String, String>> messages =
                chatSnapshot.data.sentMessages;
            return ListView.builder(
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[850],
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: messages[i]['sender'],
                            style: TextStyle(color: Colors.green),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\n\n${messages[i]['message']}",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Transform.rotate(
                          angle: 22 / 7,
                          child: FaIcon(
                            FontAwesomeIcons.share,
                            color: Colors.orange,
                            size: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: chatSnapshot.data.sentMessages.length,
            );
          }
          return Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator();
        },
      ),*/
    );
  }

  @override
  void dispose() {
    _chatBloc.dispose();
    super.dispose();
  }
}
