import 'package:scoped_model/scoped_model.dart';
import 'member_model.dart';

class SearchList extends Model {
  SearchList({this.members});

  static SearchList sample() {
    return SearchList(
      members: List.generate(
        100,
        (i) => MemberModel(id: i, name: 'member${i}', avatarUrl: ''),
      ),
    );
  }

  final List<MemberModel> members;
}
