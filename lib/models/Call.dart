class Call {
  final String profilePicture;
  final String name;
  final String phoneNumber;
  final String callType;
  final String startedAt;
  final bool sent;
  final int callerId;

  Call({
    required this.profilePicture,
    required this.name,
    required this.phoneNumber,
    required this.sent,
    required this.callerId,
    required this.callType,
    required this.startedAt,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      profilePicture: json['profile_picture'] ?? "",
      name: json['name'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      sent: json['sent'] ?? false,
      callerId: json['caller_id'] ?? 0,
      callType: json['call_type'] ?? "",
      startedAt: json['started_at'] ?? "",
    );
  }
}
