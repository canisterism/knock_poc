import 'package:scoped_model/scoped_model.dart';
import 'member_model.dart';

class SearchList extends Model {
  SearchList({this.membersMaster, this.searchWord}) {
    members = membersMaster;
  }

  static SearchList sample() {
    return SearchList(
      membersMaster: List.generate(
        100,
        (i) => MemberModel(id: i, name: 'member${i}', avatarUrl: ''),
      ),
    );
  }

  void onChangeSearchWord(String word) {
    searchWord = word;
    notifyListeners();
  }

  void selectMember({int id}) {
    members = [members[id]];
    notifyListeners();
  }

  final List<MemberModel> membersMaster;
  List<MemberModel> members;
  String searchWord;
}
