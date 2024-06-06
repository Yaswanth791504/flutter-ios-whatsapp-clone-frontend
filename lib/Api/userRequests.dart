import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:textz/main.dart';
import 'package:textz/models/Friends.dart';
import 'package:textz/models/Profile.dart';

const String BackEndUri = 'http://10.0.2.2:8000';

void createUser(Profile profile) async {
  try {
    final request = await http.post(Uri.parse('$BackEndUri/user/register'),
        body: jsonEncode({
          'name': profile.getName(),
          'about': profile.getAbout(),
          'profile_picture': profile.getImage(),
          'phone_number': profile.getPhoneNumber(),
          'email': 'user@example.com'
        }),
        headers: {
          'Content-Type': 'application/json',
        });
  } catch (e) {
    print(e);
  }
}

Future<Friends?> getUserContactsFromPhone(String number) async {
  try {
    final response = await http.get(
      Uri.parse('$BackEndUri/user/get?phone_number=$number'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data.containsKey('details')) {
      return null;
    }
    return Friends(
      name: data['name'],
      email: data['email'],
      phone_number: data['phone_number'],
      about: data['about'],
      profile_picture: data['profile_picture'],
    );
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<Profile?> getCurrentUser() async {
  try {
    final String number = await phoneNumber.getNumber();
    final request = await http.get(Uri.parse('$BackEndUri/user/get?phone_number=$number'));
    Map<String, dynamic> data = jsonDecode(request.body);
    print(request.body);
    return Profile(
      email: data['email'],
      name: data['name'],
      phoneNumber: data['phone_number'],
      image: data['profile_picture'],
      about: data['about'],
    );
  } catch (e) {
    print('Error $e');
    return null;
  }
}

Future<String?> updateProfileImage(String image) async {
  try {
    final number = await phoneNumber.getNumber();
    final request = await http.put(
      Uri.parse('$BackEndUri/user/update'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone_number": number,
        "profile_picture": image,
      }),
    );
    Map<String, dynamic> data = await jsonDecode(request.body);
    return data['profile_picture'];
  } catch (e) {
    print('Error $e');
    return null;
  }
}

Future<Map<String, dynamic>?> updateUserDetails(String name, String about, String number) async {
  try {
    final number = await phoneNumber.getNumber();
    final request = await http.put(
      Uri.parse('$BackEndUri/user/update'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone_number": number,
        "name": name,
        "about": about,
      }),
    );
    return await jsonDecode(request.body);
  } catch (e) {
    print('Error $e');
    return null;
  }
}
