import 'dart:convert';

import 'package:http/http.dart' as http;

import 'services.dart';

class PackageService {
  final path = apiPath;

  // Input Package
  Future inputPackage(
      postmanId, noResi, name, streetName, buildingName, roomNumber) async {
    var url = Uri.parse('$path/PCK/input-package');
    final response = await http.post(url, body: {
      'postman_id': postmanId,
      'no_resi': noResi,
      'name': name,
      'street_name': streetName,
      'building_name': buildingName,
      'room_number': roomNumber,
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

  // update Package
  Future updatePackage(
      packageId, noResi, name, streetName, buildingName, roomNumber) async {
    var url = Uri.parse('$path/PCK/update-data-package');
    final response = await http.put(url, body: {
      'package_id': packageId,
      'no_resi': noResi,
      'name': name,
      'street_name': streetName,
      'building_name': buildingName,
      'room_number': roomNumber,
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

  // Read Package
  Future readPackage(
    id,
    status,
  ) async {
    var url = Uri.parse('$path/PCK/read-package?id=$id&status=$status');
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

  // Read Package His
  Future readPackageHistory(
    id,
    status,
  ) async {
    var url = Uri.parse('$path/PCK/read-package-his?id=$id&status=$status');
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

  // Read Package Detail
  Future readPackageDetail(
    packageId,
  ) async {
    var url = Uri.parse('$path/PCK/read-det-pack?package_id=$packageId');
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

  // Update Package Return Status
  Future updatePackageReturnStatus(
    packageId,
  ) async {
    var url = Uri.parse('$path/PCK/update-return');
    final response = await http.post(url, body: {
      'package_id': packageId,
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

  // Update Package Status by ADMIN
  Future updatePackageStatusByAdmin(
    adminId,
    noResi,
    name,
    streetName,
    buildingName,
    roomNumber,
  ) async {
    var url = Uri.parse('$path/PCK/update-stat-admin');
    final response = await http.post(url, body: {
      'adminid': adminId,
      'no_resi': noResi,
      'name': name,
      'street_name': streetName,
      'building_name': buildingName,
      'room_number': roomNumber,
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

  // Update Package received Status
  Future updatePackageReceivedStatus(
    packageId,
  ) async {
    var url = Uri.parse('$path/PCK/update-stat-res');
    final response = await http.post(url, body: {
      'package_id': packageId,
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
