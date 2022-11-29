// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/responsemodel.dart';

final StreamController<LoginStatus> stream = StreamController();

enum LoginStatus { initial, loading, authenticated, failure, error }

class LoginRepo {
  late Requestapi data;
  late String message;
  var error;

  Stream<LoginStatus> get status async* {
    yield LoginStatus.initial;
    yield* stream.stream;
  }

  void login(String username, password) async {
    try {
      stream.add(LoginStatus.loading);
      Response response = await post(
          Uri.parse('https://stage.getsetplay.co/api/login.php'),
          body:
              jsonEncode({'username': username.trim(), 'password': password}));

      if (response.statusCode == 200) {
        data = Requestapi.fromJson(jsonDecode(response.body));
        debugPrint(data.data.toString());
        debugPrint('Login successfully');
        stream.add(LoginStatus.authenticated);
      } else {
        message = jsonDecode(response.body)['message'];
        stream.add(LoginStatus.failure);
      }
    } catch (e) {
      debugPrint(e.toString());
      error = e.toString();
      stream.add(LoginStatus.error);
    }
  }

  dispose() {
    stream.close();
  }
}
