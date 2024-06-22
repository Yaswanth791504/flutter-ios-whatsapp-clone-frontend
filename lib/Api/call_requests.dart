import 'dart:convert';
import 'dart:math';

import 'package:textz/Api/user_requests.dart';
import 'package:textz/main.dart';
import 'package:http/http.dart' as http;

Future<void> sendCall(String friendPhoneNumber, String callType) async {
  try {
    final number = await phoneNumber.getNumber();
    final String callId = Random().nextInt(100000).toString();
    print(
        '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    print(callId);
    final request = await http.post(
      Uri.parse('$backEndUri/calls/?phone_number=$number'),
      body: jsonEncode({
        "friend_phone_number": friendPhoneNumber,
        "call_type": callType,
        "call_id": callId,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (request.statusCode == 200) {
      print('Call invitation sent');
    }
  } catch (e) {
    print('Something has happened');
  }
}
