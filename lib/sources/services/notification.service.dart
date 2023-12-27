import 'dart:convert';

import 'package:http/http.dart' as http;

import 'services.dart';

class NotificationService {
  final path = apiPath;

  // Input Package
  Future readNotification(userId) async {
    var url = Uri.parse('$path/PCK/notif?Id_user=$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var status = json.decode(response.body)['status'];
      var message = json.decode(response.body)['message'];
      var body = json.decode(response.body)['data'];
      return [status, message, body];
    } else {
      return "Couldn't connect to the server, failed to fetch API!";
    }
  }
}
