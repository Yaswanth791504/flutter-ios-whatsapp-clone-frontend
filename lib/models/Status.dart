class FriendStatus {
  final String mediaLink;
  final String text;
  final String statusType;
  final String uploadedAt;

  FriendStatus({
    required this.mediaLink,
    required this.text,
    required this.statusType,
    required this.uploadedAt,
  });

  factory FriendStatus.fromJson(Map<String, dynamic> json) {
    return FriendStatus(
      mediaLink: json['media_link'] ?? '',
      text: json['text'] ?? '',
      statusType: json['status_type'],
      uploadedAt: json['uploaded_at'],
    );
  }
}

class Status {
  String name;
  final String uploadedAt;
  final String profilePicture;
  final String phoneNumber;
  final List<FriendStatus> status;

  Status({
    required this.name,
    required this.uploadedAt,
    required this.profilePicture,
    required this.phoneNumber,
    required this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    var list = json['status'] as List;
    List<FriendStatus> statusList = list.map((i) => FriendStatus.fromJson(i)).toList();

    return Status(
      name: json['name'],
      uploadedAt: json['uploaded_at'],
      profilePicture: json['profile_picture'],
      phoneNumber: json['phone_number'],
      status: statusList,
    );
  }
}
