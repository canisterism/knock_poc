import 'package:scoped_model/scoped_model.dart';

class MemberModel extends Model {
  MemberModel({this.id, this.name, this.yomigana, this.avatarUrl});
  final int id;
  final String name;
  final String yomigana;
  final String avatarUrl;
}
