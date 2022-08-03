import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  List<User> users = [];
  Future getUserData() async {
    var response = await http.get(Uri.http('https://www.googleapis.com/youtube/v3/search?port=spinnet&q=the weeknd&key=AIzaSyAmkVByQT4H4KKStNeaLd9obDkvMv_Qk6U','users'));
    var jsonData = jsonDecode(response.body);
    for(var u in jsonData){
      User user =  User(u['name'],u['email'],u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context,snapshot) {
            if(snapshot.data==null){
              return const Text('Loading...');
            }else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  return ListTile(
                    title: Text('${snapshot.data[i].name}'),
                    subtitle: Text('${snapshot.data[i].userName}'),
                    trailing: Text('${snapshot.data[i].email}'),
                  );
              },);
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class User{
    final String name, email, userName;

    User(this.name,this.email, this.userName);
}