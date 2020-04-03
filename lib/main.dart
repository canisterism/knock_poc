import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'scoped_models/serch_list.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:html/dom.dart' as dom;

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
      routes: routes,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static final routeName = 'next';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [MembersScreen(), HtmlScreen(), ShareScreen()];

  int _currentIndex = 0;

  _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.people), title: Text('members')),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              title: Text('html'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.share),
              title: Text('html'),
            )
          ]),
    );
  }
}

class HtmlScreen extends StatelessWidget {
  const HtmlScreen({Key key}) : super(key: key);
  static final routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HTML検証')),
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: [
          Html(data: '<h1>タイトルタイトル</h1>'),
          Html(data: '<h2>タイトルタイトル</h2>'),
          Html(data: '<h3>タイトルタイトル</h3>'),
          Html(data: '<h4>タイトルタイトル</h4>'),
          Html(data: '<p>タイトルタイトル</p>'),
          Html(
            data: '<p class="border">タイトルタイトル</p>',
            useRichText: false,
            customRender: (node, children) {
              if (node is dom.Element && node.className == "border") {
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: Column(children: children));
              } else {
                return null;
              }
            },
          ),
        ])),
      ),
    );
  }
}

class MembersScreen extends StatelessWidget {
  const MembersScreen({Key key}) : super(key: key);

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

class ShareScreen extends StatelessWidget {
  const ShareScreen({Key key}) : super(key: key);

  final text = 'sample text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('モーダルetc検証')),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              RaisedButton(
                child: const Text('Share'),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(text,
                      subject: text,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
              RaisedButton(
                child: const Text('webview_flutter(公式)'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(WebviewFlutterScreen.routeName);
                },
              ),
              RaisedButton(
                child: const Text('flutter_webview_plugin(コミュニティ製)'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlutterWebviewPluginScreen(),
                      settings: RouteSettings(
                        arguments: FlutterWebviewPlugin(),
                      ),
                    ),
                  );
                },
              ),
              RaisedButton(
                child: const Text('modal'),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.95),
                      child: Scaffold(
                        body: RaisedButton(
                            child: Text('next screen'),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ModalNextScreen.routeName);
                            }),
                      ),
                    ),
                  );
                },
              ),
              Builder(builder: (context) {
                final errorTextList = [
                  "140字以内で入力してください。",
                  "でも20字以上でも入力してください。"
                ];
                final inputDecoration = errorTextList.length < 1
                    ? InputDecoration(
                        hintText: 'いつもありがとう！',
                        labelText: 'メッセージ',
                        errorText: errorTextList.join("\n"))
                    : InputDecoration(
                        hintText: 'いつもありがとう！',
                        labelText: 'メッセージ',
                        errorText: errorTextList.join("\n"));

                return TextField(
                  maxLines: 5,
                  minLines: 3,
                  maxLength: 140,
                  onChanged: (e) => print(e),
                  decoration: inputDecoration,
                );
              })
            ],
          );
        },
      ),
    );
  }

  // void _launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     /// ** iOS **
  //     ///  - Set farceSafariVC to false to open main browser in iOS for using cookies/context of the app and being able to do SSO.
  //     ///    cf. https://github.com/flutter/plugins/blob/master/packages/url_launcher/url_launcher/lib/url_launcher.dart#L25

  //     /// ** Android **
  //     ///  - Set forceWebView to true to open WebView. Unlike iOS,
  //     ///    browser context is shared across WebViews in Android.
  //     ///    cf. https://github.com/flutter/plugins/blob/master/packages/url_launcher/url_launcher/lib/url_launcher.dart#L40
  //     await launch(url, forceWebView: true);
  //   } else {
  //     // TODO(kato1628): error handling..., https://github.com/giftee/sputnik/issues/362
  //     throw Exception('Could not launch $url');
  //   }
  // }
}

// A builder is used to retrieve the context immediately
// surrounding the RaisedButton.
//
// The context's `findRenderObject` returns the first
// RenderObject in its descendent tree when it's not
// a RenderObjectWidget. The RaisedButton's RenderObject
// has its position and size after it's built.

class ModalNextScreen extends StatelessWidget {
  const ModalNextScreen({Key key}) : super(key: key);
  static final routeName = 'next';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('this is next screen'),
    );
  }
}

Map<String, Widget Function(BuildContext context)> routes = {
  ModalNextScreen.routeName: (context) => ModalNextScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  WebviewFlutterScreen.routeName: (context) => WebviewFlutterScreen(),
  FlutterWebviewPluginScreen.routeName: (context) =>
      FlutterWebviewPluginScreen(),
};

class WebviewFlutterScreen extends StatelessWidget {
  const WebviewFlutterScreen({Key key}) : super(key: key);
  static final routeName = 'webview_flutter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Github')),
        body: WebView(
          initialUrl: 'https://github.com',
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {},
        ));
  }
}

class FlutterWebviewPluginScreen extends StatelessWidget {
  FlutterWebviewPluginScreen({
    Key key,
  }) : super(key: key);
  static final routeName = 'flutter_webview_plugin';

  @override
  Widget build(BuildContext context) {
    final FlutterWebviewPlugin flutterWebviewPlugin =
        ModalRoute.of(context).settings.arguments;
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url == 'https://github.com/enterprise') {
        flutterWebviewPlugin.close();
        flutterWebviewPlugin.dispose();
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      }
    });
    return WebviewScaffold(
      appBar: AppBar(title: Text('Github')),
      url: 'https://github.com',
    );
  }
}
