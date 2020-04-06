import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'scoped_models/serch_list.dart';
import 'package:scoped_model/scoped_model.dart';
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
        child: Html(
          data: '''
              <div class="decoration-head">コンテンツの見出し</div>
              <div class="decoration-sub-title">サブタイトルなどに使う</div>
              <div class="decoration-small-sub-title">小さいサブタイトルなどに使う？</div>
              <p class="body">本文 クラス名: body</p>
              <p class="body">font-size: 14px, linehight: 2</p>
              <a class="text-link" href="/">テキストリンク</a>
              <div class="caption">仕様・注意事項等のサブテキスト クラス名: caption</div>
              <div class="caption">font-size: 12px, linehight: 1.6</div>
              <table>
                <tr>
                  <th>項目1</th>
                  <th>Hoge</th>
                  <th>Hoge</th>
                </tr>
                <tr>
                  <td>項目2</td>
                  <td>Fuga</td>
                  <td>Fuga</td>
                </tr>
                <tr>
                  <td>項目3</td>
                  <td>Piyo</td>
                  <td>Piyo</td>
                </tr>
              </table>
              <div class="box-list--alert">
                <ul>
                  <li>このボックスは長文で注意喚起やエラー詳細を出したいときに使用するスペースです</li>
                  <li>このボックスは長文で注意喚起やエラー詳細を出したいときに使用するスペースです</li>
                  <li>このボックスは長文で注意喚起やエラー詳細を出したいときに使用するスペースです</li>
                </ul>
              </div>
              <div class="box-list--attention">このボックスは長文で注意喚起やエラー詳細を出したいときに使用するスペースです</div>

            ''',
          // CSSと同じノリで書ける
          style: {
            ".decoration-head":
                Style(fontSize: FontSize(24), fontWeight: FontWeight.bold),
            ".decoration-sub-title": Style(
                fontSize: FontSize(20),
                fontWeight: FontWeight.bold,
                height: 40),
            ".decoration-small-sub-title": Style(
              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
              fontSize: FontSize(16),
              fontWeight: FontWeight.bold,
            ),
            ".body": Style(),
            ".text-link": Style(textDecoration: TextDecoration.none),
            ".caption": Style(fontSize: FontSize(12), color: Colors.grey),
            ".box-list--alert": Style(color: Colors.red),
            ".box-list--attention": Style(color: Colors.grey),
          },
          // keyはhtml tagの名前
          customRender: {
            "div": customRenderer,
            "p": customRenderer,
            "a": customRenderer,
          },
        ),
      )),
    );
  }

  Widget Function(RenderContext, Widget, Map<String, String>, dom.Element)
      get customRenderer =>
          (RenderContext context, Widget child, attributes, _) {
            switch (attributes['class']) {
              case 'decoration-head':
                return Container(color: Colors.white, child: child);
              case 'decoration-sub-title':
                return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: const Color.fromRGBO(240, 139, 113, 1),
                            width: 2),
                      ),
                    ),
                    child: child);
              case 'decoration-small-sub-title':
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: const Color.fromRGBO(240, 139, 113, 1),
                            width: 2),
                      ),
                    ),
                    child: child);
              case 'body':
                return Container(
                  child: child,
                  padding: EdgeInsets.all(0),
                );
              case 'text-link':
                return child;
              case 'caption':
                return child;
              case 'box-list--alert':
                return Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(250, 234, 234, 1),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: child);
              case 'box-list--attention':
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(248, 248, 248, 1),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: child);
              default:
                return child;
            }
          };
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
                child: const Text('webview'),
                onPressed: () {
                  Navigator.of(context).pushNamed(GithubScreen.routeName);
                  // _launchUrl(
                  //   'https://google.com',
                  // );
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
  GithubScreen.routeName: (context) => GithubScreen(),
};

class GithubScreen extends StatelessWidget {
  const GithubScreen({Key key}) : super(key: key);
  static final routeName = 'github';

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
