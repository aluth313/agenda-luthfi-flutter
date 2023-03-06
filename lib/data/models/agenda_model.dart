import 'package:meta/meta.dart';
import 'dart:convert';

Agenda agendaFromJson(String str) => Agenda.fromJson(json.decode(str));

String agendaToJson(Agenda data) => json.encode(data.toJson());

class Agenda {
  Agenda({
    required this.id,
    required this.title,
    required this.description,
    required this.datetime,
    required this.attachment,
    required this.reminder,
  });

  final int id;
  final String title;
  final String description;
  final String datetime;
  final String attachment;
  final String reminder;

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        attachment: json["attachment"],
        reminder: json["reminder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "datetime": datetime,
        "attachment": attachment,
        "reminder": reminder,
      };
}
