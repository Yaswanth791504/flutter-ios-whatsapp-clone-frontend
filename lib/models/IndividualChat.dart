class IndividualChat {
  IndividualChat(
      {required this.name,
      required this.phone_number,
      required this.about,
      required this.profile_picture,
      required this.last_message,
      required this.last_message_time,
      this.last_message_type = '',
      required this.isOnline,
      this.email = ''});

  final String last_message_type;
  final String email;
  final String name;
  final String phone_number;
  final String about;
  final String profile_picture;
  final String last_message;
  final String last_message_time;
  final bool isOnline;
}
