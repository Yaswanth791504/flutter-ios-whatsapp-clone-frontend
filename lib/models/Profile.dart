class Profile {
  Profile({
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.email,
    this.about = 'Hey there, I\' using whatsApp clone',
  });
  String email;
  String name;
  String image;
  String about;
  String phoneNumber;

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  String getImage() {
    return image;
  }

  String getAbout() {
    return about;
  }

  void setEmail(String email) {
    email = email;
  }

  void setName(String name) {
    name = name;
  }

  void setImage(String image) {
    image = image;
  }

  void setPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber;
  }

  void setAbout(String about) {
    about = about;
  }
}
