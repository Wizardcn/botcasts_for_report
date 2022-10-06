// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    Users({
        required this.id,
        required this.uid,
        required this.username,
        required this.email,
        required this.profilePicUrl,
    });

    String id;
    String uid;
    String username;
    String email;
    String profilePicUrl;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        profilePicUrl: json["profile_pic_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "username": username,
        "email": email,
        "profile_pic_url": profilePicUrl,
    };
}
