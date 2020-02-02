import 'package:flutter/material.dart';
import 'scoped_models/serch_list.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'knock poc',
        style: TextStyle(fontSize: 40),
      )),
      body: ScopedModel<SearchList>(
        model: SearchList.sample(),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSearchInputArea(context),
            _buildMembersArea(context),
          ],
        ),
      ),
    );
  }

  _buildSearchInputArea(BuildContext context) {
    return ScopedModelDescendant<SearchList>(
      builder: (context, child, model) => SliverList(
        delegate: SliverChildListDelegate([
          Align(
            alignment: Alignment.center,
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
        ]),
      ),
    );
  }

  _buildMembersArea(BuildContext context) {
    return ScopedModelDescendant<SearchList>(
      builder: (context, child, model) => SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: FlatButton(
                child: Text(model.members[index].name),
                onPressed: () => model.selectMember(id: index),
              ),
            );
          },
          childCount: model.members.length,
        ),
      ),
    );
  }
}
