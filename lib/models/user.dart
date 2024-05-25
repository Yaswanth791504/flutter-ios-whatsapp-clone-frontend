class User {
  User({
    required this.name,
    required this.lastMessage,
    required this.seen,
    required this.time,
    required this.image,
  });
  String name;
  String image;
  String lastMessage;
  String time;
  bool seen;
}
