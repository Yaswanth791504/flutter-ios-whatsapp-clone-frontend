import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class IOSHelpers {
  static Future<String?> uploadImage(String imageSource) async {
    final Uri uri = Uri.parse('https://api.cloudinary.com/v1_1/drv13gs45/upload');
    const String preset = 'lqdv51ug';

    final imageFile = await http.MultipartFile.fromPath(
      'file',
      imageSource,
      filename: basename(imageSource),
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = preset
      ..files.add(imageFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['secure_url'];
    } else {
      print('Something went wrong: ${response.statusCode}');
      return null;
    }
  }

  static String getRefinedPhoneNumber(String number) {
    number = number.trim();
    number = number.split(' ').join('');
    if (number.contains('+91')) {
      number = number.substring(3).trim();
    }

    return number;
  }
}
