import 'dart:convert';

import 'package:http/http.dart' as http;

import 'services.dart';

class AuthService {
  final path = apiPath;

  // SignIn
  Future signIn(role, email, password) async {
    var url = Uri.parse(
        '$path/UM/login?status=$role&email=$email&password=$password');
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

  // SignUp Admin
  Future signUpAdmin(
      name, email, password, buildingName, address, biography) async {
    var url = Uri.parse('$path/UM/sign-up-admin-bd');
    final response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'BuildingName': buildingName,
      'Address': address,
      'Biography': biography,
    });
    if (response.statusCode == 200) {
      var status = json.decode(response.body)['status'];
      var message = json.decode(response.body)['message'];
      var body = json.decode(response.body)['data'];
      return [status, message, body];
    } else {
      return "Couldn't connect to the server, failed to fetch API!";
    }
  }

  // SignUp Postman
  Future signUpPostman(name, email, password) async {
    var url = Uri.parse('$path/UM/sign-up-postman');
    final response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var status = json.decode(response.body)['status'];
      var message = json.decode(response.body)['message'];
      var body = json.decode(response.body)['data'];
      return [status, message, body];
    } else {
      return "Couldn't connect to the server, failed to fetch API!";
    }
  }

  // Get Profile
  Future getProfile(id, role) async {
    var url = Uri.parse('$path/UM/see-profile?id=$id&status=$role');
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

  // Update Profile resident
  Future updateProfileResident(id, name, surname, email, password) async {
    var url = Uri.parse('$path/UM/update-profile-res');
    final response = await http.put(url, body: {
      'residentid': id,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var status = json.decode(response.body)['status'];
      var message = json.decode(response.body)['message'];
      var body = json.decode(response.body)['data'];
      return [status, message, body];
    } else {
      return "Couldn't connect to the server, failed to fetch API!";
    }
  }

  // Update Profile Admin
  Future updateProfileAdmin(
      id, buildingId, name, email, password, buildingName, address, bio) async {
    var url = Uri.parse('$path/UM/update-profile-adm');
    final response = await http.put(url, body: {
      'admin_id': id,
      'building_id': buildingId,
      'name': name,
      'email': email,
      'password': password,
      'BuildingName': buildingName,
      'Address': address,
      'Biography': bio,
    });
    if (response.statusCode == 200) {
      var status = json.decode(response.body)['status'];
      var message = json.decode(response.body)['message'];
      var body = json.decode(response.body)['data'];
      return [status, message, body];
    } else {
      return "Couldn't connect to the server, failed to fetch API!";
    }
  }

  // Update Profile Postman
  Future updateProfilePostman(id, name, email, password) async {
    var url = Uri.parse('$path/UM/update-profile-pos');
    final response = await http.put(url, body: {
      'postman_id': id,
      'name': name,
      'email': email,
      'password': password,
    });
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
