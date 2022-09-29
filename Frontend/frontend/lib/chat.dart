import 'package:flutter/material.dart';
import 'package:frontend/message.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChatPage());
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() {
    return ChatPageState();
  }
}

List<Message> messages = <Message>[];
final List<String> strings = <String>[];

class ChatPageState extends State<ChatPage> {
  TextEditingController textEdit = TextEditingController();
  late StompClient client;

  @override
  void initState() {
    super.initState();
    client = StompClient(
        config: StompConfig.SockJS(
      url: 'http://localhost:8080/ws',
      onConnect: onConnect,
      onWebSocketError: (dynamic error) => print(error.toString()),
    ));
    client.activate();
  }

  void onConnect(StompFrame frame) {
    print("connected");
    // client.subscribe(destination: '/user/max/queue/msg', callback: onMessage);
    client.subscribe(destination: '/topic/chat', callback: onMessageTopic);
    client.send(destination: '/app/register', body: 'max', headers: {});
    print("subscribed and registered");
  }

  void onMessageTopic(StompFrame frame) {
    print(frame.body);
    String json = '${frame.body}';
    Message m = Message.fromJson(jsonDecode(json));
    if (m.from != 'max') {
      setState(() {
        strings.insert(0, m.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat!"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: "enter a message"),
                  controller: textEdit,
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: strings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(strings[index]),
                        );
                      }))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: addItemToList,
        child: const Icon(Icons.send),
      ),
    );
  }

  void addItemToList() {
    if (textEdit.text.isNotEmpty) {
      setState(() {
        strings.insert(0, textEdit.text);
      });

      client.send(
          destination: '/app/message',
          body: '{"to": "greg", "text": "${textEdit.text}"}',
          headers: {});

      textEdit.text = '';
    }
  }
}
