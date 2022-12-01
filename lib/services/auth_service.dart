import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  final String _baseUrl = "identitytoolkit.googleapis.com";
  final String _firebaseToken = "AIzaSyDg2y3nyF_XR-zaRtqfA880XhzIaMqZzVM";

  //método para crear un usuario nuevo
  Future<String?> crearUsuario(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  //método para login
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    //print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }
}
