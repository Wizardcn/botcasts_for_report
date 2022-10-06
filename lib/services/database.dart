import 'package:botcasts/models/content_types.dart';
import 'package:botcasts/models/mongo_users.dart';
import 'dart:convert';
import 'package:botcasts/models/contents.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  late List<Content> _contentsFromAPI, _newFromAPI, _hotFromAPI;
  late List<ContentType> _contentTypeFromAPI;
  late Users _usersFromAPI;

  Future<List<Content>> getAllContents() async {
    var url = Uri.parse("https://domain.com/service/contents/");
    var response = await http.get(url);
    _contentsFromAPI = contentsFromJson(utf8.decode(response.body.codeUnits));
    return _contentsFromAPI;
  }

  Future<List<Content>> getNewContents() async {
    var url = Uri.parse("https://domain.com/service/contents/recommended/new");
    var response = await http.get(url);
    _newFromAPI = contentsFromJson(utf8.decode(response.body.codeUnits));
    return _newFromAPI;
  }

  Future<List<Content>> getHotContents() async {
    var url = Uri.parse("https://domain.com/service/contents/recommended/hot");
    var response = await http.get(url);
    _hotFromAPI = contentsFromJson(utf8.decode(response.body.codeUnits));
    return _hotFromAPI;
  }

  Future<List<ContentType>> getContentTypes() async {
    var url = Uri.parse("https://domain.com/service/contents/types");
    var response = await http.get(url);
    _contentTypeFromAPI =
        contentTypeFromJson(utf8.decode(response.body.codeUnits));
    return _contentTypeFromAPI;
  }

  Future<Users> getUserDetail() async {
    var url = Uri.parse("https://domain.com/service/users/$uid");
    var response = await http.get(url);
    _usersFromAPI = usersFromJson(utf8.decode(response.body.codeUnits));
    return _usersFromAPI;
  }

  Future<String> updateUserDetail(String username, email, profilePicUrl) async {
    var url = Uri.parse('https://domain.com/service/users/');
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    var body = {
      "uid": uid,
      "username": username,
      "email": email,
      "profile_pic_url": profilePicUrl
    };
    http.Response response =
        await http.put(url, headers: headers, body: jsonEncode(body));
    return response.body;
  }

  Future createUserDetail(String username, String email, String password,
      String profilePicUrl) async {
    var url = Uri.parse('https://domain.com/service/users/');
    var body = {
      "uid": uid,
      "username": username,
      "email": email,
      "password": password,
      "profile_pic_url": profilePicUrl
    };
    var headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return response.body;
  }
}
