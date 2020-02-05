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
        primarySwatch: MaterialColor(
          0xFFFFFFFF,
          const <int, Color>{
            50: const Color(0xFFFFFFFF),
            100: const Color(0xFFFFFFFF),
            200: const Color(0xFFFFFFFF),
            300: const Color(0xFFFFFFFF),
            400: const Color(0xFFFFFFFF),
            500: const Color(0xFFFFFFFF),
            600: const Color(0xFFFFFFFF),
            700: const Color(0xFFFFFFFF),
            800: const Color(0xFFFFFFFF),
            900: const Color(0xFFFFFFFF),
          },
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(500, 150),
        child: AppBar(
          elevation: 0,
          title: Text(
            '* giftee',
            style: TextStyle(fontSize: 48),
          ),
          bottom: PreferredSize(
            preferredSize: Size(500, 40),
            child: BottomAppBar(
              elevation: 0,
              child: Text(
                '担当者をお選びください',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
      body: ScopedModel<SearchList>(
        model: SearchList.sample(),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildAlphabetArea(context),
          ],
        ),
      ),
    );
  }

  _buildAlphabetArea(BuildContext context) {
    return ScopedModelDescendant<SearchList>(
      builder: (context, child, model) => SliverPadding(
        padding: EdgeInsets.fromLTRB(
          56,
          80,
          56,
          56,
        ),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 90.0,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey.withAlpha(50))]),
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text(
                    japaneseAlphabets[index],
                    style: TextStyle(fontSize: 32),
                  ),
                  onPressed: () => model.selectMember(id: index),
                ),
              );
            },
            childCount: japaneseAlphabets.length,
          ),
        ),
      ),
    );
  }
}
