import 'package:flutter/material.dart';
import 'package:flutter_poc/scoped_models/serch_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final searchList = SearchList.sample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('knock poc')),
      body: ListView.builder(
        itemCount: searchList.members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchList.members[index].name),
          );
        },
      ),
    );
  }
}
