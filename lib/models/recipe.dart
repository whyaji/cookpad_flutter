import 'package:cookpad_flutter/utils.dart';

class RecipeField {
  static const createdTime = 'createdTime';
}

class Recipe {
  DateTime createdTime;
  final String penulis;
  String judul;
  String bahan;
  String langkah;
  String id;
  bool isDone;

  Recipe(
      {required this.createdTime,
      required this.penulis,
      required this.judul,
      required this.bahan,
      required this.langkah,
      this.isDone = false,
      required this.id});

  static Recipe fromJson(Map<String, dynamic> json) => Recipe(
        createdTime: Utils.toDateTime(json['createdTime']),
        penulis: json['penulis'],
        judul: json['judul'],
        bahan: json['bahan'],
        langkah: json['langkah'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'penulis': penulis,
        'judul': judul,
        'bahan': bahan,
        'langkah': langkah,
        'id': id,
        'isDone': isDone,
      };
}
