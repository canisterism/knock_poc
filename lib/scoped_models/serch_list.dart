import 'package:scoped_model/scoped_model.dart';
import '../models/member.dart';

class SearchList extends Model {
  SearchList({this.membersMaster, this.searchWord}) {
    members = membersMaster;
  }

  static SearchList sample() {
    return SearchList(membersMaster: sampleMembers());
  }

  void onChangeSearchWord(String word) {
    searchWord = word;
    notifyListeners();
  }

  void selectMember({int id}) {
    members = [members[id]];
    notifyListeners();
  }

  final List<Member> membersMaster;
  List<Member> members;
  String searchWord;
}

final japaneseAlphabets = [
  'わ',
  'ら',
  'や',
  'ま',
  'は',
  'な',
  'た',
  'さ',
  'か',
  'あ',
  ' ',
  'り',
  ' ',
  'み',
  'ひ',
  'に',
  'ち',
  'し',
  'き',
  'い',
  ' ',
  'る',
  'ゆ',
  'む',
  'ふ',
  'ぬ',
  'つ',
  'す',
  'く',
  'う',
  ' ',
  'れ',
  ' ',
  'め',
  'へ',
  'ね',
  'て',
  'せ',
  'け',
  'え',
  ' ',
  'ろ',
  'よ',
  'も',
  'ほ',
  'の',
  'と',
  'そ',
  'こ',
  'お'
];
