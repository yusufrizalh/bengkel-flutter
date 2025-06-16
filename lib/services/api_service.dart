// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:flutter_lab/models/document_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Untuk MediaType
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.4.100/flutter-api/apis';

  // Create/Upload
  static Future<Document> uploadDocument({
    required String title,
    required String description,
    required File file,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload.php'),
      );

      // Add fields
      request.fields['title'] = title;
      request.fields['description'] = description;

      // Add file
      final mimeType = lookupMimeType(file.path);
      final fileType = mimeType!.split('/')[0]; // 'image' atau 'application'

      var fileStream = http.ByteStream(file.openRead());
      var length = await file.length();

      var multipartFile = http.MultipartFile(
        'file',
        fileStream,
        length,
        filename: file.path.split('/').last,
        contentType: MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
      );

      request.files.add(multipartFile);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      final responseJson = json.decode(responseData);

      if (response.statusCode == 200) {
        // return Document.fromJson(json.decode(responseData));
        if (responseJson is Map<String, dynamic>) {
          return Document.fromJson(responseJson);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
          'Failed to upload document: ${json.decode(responseData)['message']}',
        );
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Read
  static Future<List<Document>> getDocuments() async {
    final response = await http.get(Uri.parse('$baseUrl/documents.php'));

    if (response.statusCode == 200) {
      final dynamic responseBody = json.decode(response.body);
      if (responseBody is List) {
        return responseBody
            .map((dynamic item) => Document.fromJson(item))
            .toList();
      } else if (responseBody is Map && responseBody.containsKey('records')) {
        return (responseBody['records'] as List)
            .map((dynamic item) => Document.fromJson(item))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load documents: ${response.statusCode}');
    }
  }

  // Get single document
  static Future<Document> getDocument(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/document.php?id=$id'));

    if (response.statusCode == 200) {
      return Document.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load document');
    }
  }

  // Update
  static Future<Document> updateDocument(Document document) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(document.toJson()),
    );

    if (response.statusCode == 200) {
      return Document.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update document');
    }
  }

  // Delete
  static Future<void> deleteDocument(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete.php?id=$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete document');
    }
  }

  //==============================================================

  Future<User> login(String user_email, String user_password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'user_email': user_email, 'user_password': user_password},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<User> register(
    String user_name,
    String user_email,
    String user_password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'user_name': user_name,
        'user_email': user_email,
        'user_password': user_password,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }
}
