import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
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
          child: Column(
            children: [
              Html(
                // なんか知らんけどcustomRenderのスタイルが当たってない
                data: '''
                <div class="box-list--alert">
                  <p>
                      <strong>
                          スターバックス コーヒー ジャパン 株式会社からのお知らせ
                      </strong>
                  </p>
                  <p>
                      新型コロナウイルス感染拡大と予防への対応について。<a href="https://example.com">詳細はこちらからご確認ください。</a>
                  </p>
                </div>
                <div class="box-list--attention">
                  <p>
                      <strong>
                          スターバックス コーヒー ジャパン 株式会社からのお知らせ
                      </strong>
                  </p>
                  <p>
                      新型コロナウイルス感染拡大と<span class="alert">予防への対応</span>について。<a href="https://example.com">詳細はこちらからご確認ください。</a>
                  </p>
                </div>
                <div>
                  <h1 class="decoration-sub-title">
                      コーヒーのおいしさを引き立てるフードをギフトチケットとして贈れます
                  </h1>
                  <p>スターバックスの店舗にて、お好きなフード1つ（税込300円まで）と引き換えいただけるチケットです。
                  </br>お会計の際にレジにてギフトチケット画面をご提示または印刷してお持ちください。
                  </br>注文したフード代が300円（税込）を超える場合は、超えた金額をお支払ください。また、つり銭はご容赦ください</p>
                </div>
                <div>
                  <h1 class="decoration-sub-title">
                      フードチケットのギフトで応援や感謝を伝えよう
                  </h1>
                  <img src="https://dummyimage.com/1000x1000/ccc/999.png&text=dummy" alt="img">
                  <p>
                      コーヒーのおいしさを引き立ててくれる魅力的なフードメニューの中から、ギフトシーンに合わせたgifteeのレコメンドフードをご紹介いたします。シーンによって時には主役になるフードと一緒に、<span class="primary">応援や感謝など伝えたい気持ちを一緒</span>に送ってください。
                  </p>
                </div>
                <div>
                  <h2 class="decoration-sub-title--small">
                      【朝食】1日のはじまりを応援したい人へ
                  </h2>
                  <img src="https://dummyimage.com/341x244/ccc/999.png&text=dummy" alt="img">
                  <p>※価格の不足分は差額をお支払いただくことでお使いいただけます。
                  </br>※一部対象外のフードがございます。
                  </br>※一部ご使用になれない店舗がございます。</p>
                </div>
                <div>
                  <h2 class="decoration-sub-title--small">
                      【昼食】食事しながら仕事をがんばる人へ
                  </h2>
                  <img src="https://dummyimage.com/341x244/ccc/999.png&text=dummy" alt="img">
                  <p>※価格の不足分は差額をお支払いただくことでお使いいただけます。
                  </br>※一部対象外のフードがございます。
                  </br>※一部ご使用になれない店舗がございます。</p>
                </div>
                <div>
                  <h2 class="decoration-sub-title--small">
                      【デザート】仕事の合間に一息入れて欲しい人へ
                  </h2>
                  <img src="https://dummyimage.com/341x244/ccc/999.png&text=dummy" alt="img">
                  <p>※価格の不足分は差額をお支払いただくことでお使いいただけます。
                  </br>※一部対象外のフードがございます。
                  </br>※一部ご使用になれない店舗がございます。</p>
                </div>
                <div class="line"></div>
                <ol>
                  <p><strong>【作り方は簡単 3ステップ♪】</strong></p>
                  <li>写真データを集める</li>
                  <li>集めた写真をアップロード</li>
                  <li>テンプレートを選んで、写真と文字を入れていくだけ！</li>
                </ol>
                <div>
                  <p><a href="https://example.com" class="text-link">公式ページはこちら</a></p>
                </div>
              ''',
                style: {
                  ".decoration-sub-title": Style(),
                  ".decoration-sub-title--small": Style(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  ),
                  ".primary": Style(
                    color: const Color.fromRGBO(240, 139, 113, 1),
                  ),
                  ".body": Style(),
                  ".text-link": Style(textDecoration: TextDecoration.none),
                  ".caption": Style(fontSize: FontSize(12), color: Colors.grey),
                  ".box-list--alert": Style(color: Colors.red),
                  ".alert": Style(color: Colors.red),
                  ".box-list--attention": Style(color: Colors.grey),
                  ".red": Style(color: Colors.red),
                },
                // keyはhtml tagの名前
                // レイアウトなどの制御はこっち
                customRender: {
                  "*": customRenderer(context),
                },
              ),
              Html(
                data: '''
                <div class="caption">
                  <ul>
                    <li>日本国内のスターバックス店舗でご使用になれます。一部ご使用になれない店舗がございます。</li>
                    <li>店舗で引き換える際に店舗内が圏外になる可能性がございます。チケット画面をあらかじめご用意の上、店舗でご利用ください。</li>
                    <li>ギフトチケットには、有効期限があります。チケット画面にて期限をお確かめの上、有効期限内にご利用ください。</li>
                    <li>商品交換はスマートフォンに対応しております。パソコンの場合は、用紙に印刷いただくことで交換することができます。詳細はお知らせをご覧ください。</li>
                    <li>スターバックスの店舗にてお好きなフード1つ（税込300円まで）とお引き換えいただけるチケットです。</li>
                    <li>1つのフードにつき、フードチケット1枚をご利用いただけます。</li>
                  </ul>
                  <p>※税込300円を超える場合、超えた金額をお支払いください。</p>
                  <p>※つり銭はご容赦ください。一部対象外のフードがございます。</p>
                  <p>※複写、改竄などの不正行為が発生した場合、利用を停止することがございます。</p>
                </div>
                <div class="caption">
                  <p class="alert">※日本国外のIPから、ギフトチケットをご利用することは出来ません。</p>
                  <table>
                    <colgroup>
                      <col width="20%"/>
                      <col width="80%"/>
                    </colgroup>
                    <tr>
                      <td class="td-head">内容量</td>

                      <td class="td-content">：牧草牛100%ハンバーグ200g × 4個</td>
                    </tr>
                    <tr>
                      <td class="td-head">賞味期限</td>

                      <td class="td-content">：出荷日より90日（冷凍時）</td>
                    </tr>
                    <tr>
                      <td class="td-head">保存方法</td>

                      <td class="td-content">：冷凍　※クール便にてお届けいたします。</td>
                    </tr>
                    <tr>
                      <td class="td-head">アレルギー</td>

                      <td class="td-content">：牛肉、大豆</td>
                    </tr>
                  </table>
                  <p><strong>【eGift対象外店舗】</strong></p>
                  <p>フルーツバーＡＯＫＩ　うすい店・果汁工房果琳　ザ・モール長町店・果汁工房果琳　イオンモール木曽川店・フルーツバーＡＯＫＩ　静岡パルコ店・フルーツバーＡＯＫＩ　エスパル郡山店・フルーツバーＡＯＫＩ　ららぽーと海老名店・Wonder
                    Fruits　北千住マルイ店・Wonder Fruits　LINKS UMEDA店</p>
                </div>
              ''',
                style: {
                  ".decoration-sub-title": Style(),
                  ".decoration-sub-title--small": Style(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  ),
                  ".primary": Style(
                    color: const Color.fromRGBO(240, 139, 113, 1),
                  ),
                  ".body": Style(),
                  ".text-link": Style(textDecoration: TextDecoration.none),
                  ".caption": Style(fontSize: FontSize(12), color: Colors.grey),
                  ".box-list--alert": Style(color: Colors.red),
                  ".alert": Style(color: Colors.red),
                  ".box-list--attention": Style(color: Colors.grey),
                  ".red": Style(color: Colors.red),
                },
                // keyはhtml tagの名前
                // レイアウトなどの制御はこっち
                customRender: {
                  "*": customRenderer(context),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Function(RenderContext, Widget, Map<String, String>, dom.Element)
      customRenderer(BuildContext buildContext) =>
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
              case 'decoration-sub-title--small':
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
              case 'line':
                return Divider();
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
                child: const Text('webview(official plugin/Github)'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(WebviewFlutterScreen.routeName);
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
                child: const Text('webview(official plugin/local kitty)'),
                onPressed: () {
                  Navigator.of(context).pushNamed(LocalKittyScreen.routeName);
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
              RaisedButton(
                  child: const Text('BottomUp modal '),
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  }),
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          BottomUpModalScreen(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
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

class BottomUpModalScreen extends StatelessWidget {
  const BottomUpModalScreen({Key key}) : super(key: key);
  static final routeName = 'bottomUpModal';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('this is bottomUpModal screen'),
      ),
    );
  }
}

Map<String, Widget Function(BuildContext context)> routes = {
  ModalNextScreen.routeName: (context) => ModalNextScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LocalKittyScreen.routeName: (context) => LocalKittyScreen(),
  WebviewFlutterScreen.routeName: (context) => WebviewFlutterScreen(),
  FlutterWebviewPluginScreen.routeName: (context) =>
      FlutterWebviewPluginScreen(),
  BottomUpModalScreen.routeName: (context) => BottomUpModalScreen(),
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

class LocalKittyScreen extends StatelessWidget {
  const LocalKittyScreen({Key key}) : super(key: key);
  static const routeName = 'kitty';

  @override
  Widget build(BuildContext context) {
    final noticeUrlDomain = 'https://be259afa.ngrok.io';
    return Scaffold(
        appBar: AppBar(title: Text(noticeUrlDomain)),
        body: WebView(
          initialUrl: noticeUrlDomain,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (rawUrl) {
            final url = Uri.parse(rawUrl);
            if (url.hasQuery) {
              final to = url.queryParameters['app_redirect_to'];
              // expect ?app_redirect_to=item_skus/1
              final matches = RegExp(r'(.*)\/(\d)').firstMatch(to);
              final model = matches.group(1);
              final id = matches.group(2);
              print('model: $model');
              print('id: $id');
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            } else if (url.origin.contains(noticeUrlDomain)) {
              // do nothing
            } else {
              _launchUrl(rawUrl);
            }
          },
        ));
  }
}

void _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    // TODO(kato1628): error handling..., https://github.com/giftee/sputnik/issues/362
    throw Exception('Could not launch $url');
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
