// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AnimeSchedule extends Equatable {
  const AnimeSchedule({
    required this.day,
    required this.schedule,
  });

  final String day;
  final List<List<Anime>> schedule;

  AnimeSchedule copyWith({
    String? day,
    List<List<Anime>>? schedule,
  }) {
    return AnimeSchedule(
      day: day ?? this.day,
      schedule: schedule ?? this.schedule,
    );
  }

  factory AnimeSchedule.fromJson(Map<String, dynamic> json) {
    return AnimeSchedule(
      day: json['day'],
      schedule: (json['list'] as List<dynamic>).map((list) {
        return (list as List<dynamic>).map((item) {
          return Anime.fromMap(item);
        }).toList();
      }).toList(),
    );
  }
  @override
  String toString() => 'AnimeSchedule(day: $day, anime: $schedule)';

  @override
  List<Object?> get props => [day];
}

class Anime extends Equatable {
  const Anime({
    required this.name,
    required this.episodeNo,
    required this.imgSrc,
    required this.time,
  });

  final String name;
  final String episodeNo;
  final String imgSrc;
  final String time;

  Anime copyWith({
    String? name,
    String? episodeNo,
    String? imgSrc,
    String? time,
  }) {
    return Anime(
      name: name ?? this.name,
      episodeNo: episodeNo ?? this.episodeNo,
      imgSrc: imgSrc ?? this.imgSrc,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'episodeNo': episodeNo,
      'imgSrc': imgSrc,
      'time': time,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      name: map['name'],
      episodeNo: map['episode_no'],
      imgSrc: map['img_src'],
      time: map['time'],
    );
  }
  factory Anime.empty() {
    return const Anime(
        name: "name", episodeNo: 'episode no', imgSrc: 'imgsrc', time: 'time');
  }
  String toJson() => json.encode(toMap());

  factory Anime.fromJson(String source) =>
      Anime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Anime(name: $name, episodeNo: $episodeNo, imgSrc: $imgSrc, time: $time)';
  }

  @override
  List<Object?> get props => [name, imgSrc, time, episodeNo];
}
