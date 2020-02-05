class Member {
  Member({this.email, this.name, this.photoUrl, this.slackId, this.sortKey});
  final String name;
  // final String yomigana;
  final String email;
  final String slackId;
  final String photoUrl;
  final int sortKey;
}

List<Member> sampleMembers() {
  return [
    Member(
        email: 'flutter@dart.com',
        name: 'Flutter',
        photoUrl:
            'https://pbs.twimg.com/profile_images/1089490651605954561/12XHsCZG_400x400.jpg',
        slackId: 'AAAAAAAA',
        sortKey: 1)
  ];
}
