import 'dart:convert';
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:http/http.dart' show Client;

class CommentsSrvice extends ChangeNotifier {
  List<CommentsModel> _data = [];
  List<CommentsModel> get dataComments => _data;
  final url = 'https://jsonplaceholder.typicode.com';
  Client http = Client();

  Future<List<CommentsModel>> getComments() async {
    final res = await http.get("$url/comments");
    if (res.statusCode == 200) {
      final result = json.decode(res.body).cast<Map<String, dynamic>>();
      _data = result
          .map<CommentsModel>((json) => CommentsModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
