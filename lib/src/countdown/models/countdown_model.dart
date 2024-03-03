// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CountdownModel {
  CountdownModel({
    required this.title,
    required this.imgUrl,
    required this.countdown,
    required this.episode,
    required this.slug,
  });

  final String title;
  final String imgUrl;
  final String countdown;
  final String episode;
  final String slug;

  CountdownModel copyWith({
    String? title,
    String? imgUrl,
    String? countdown,
    String? episode,
    String? slug,
  }) {
    return CountdownModel(
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      countdown: countdown ?? this.countdown,
      episode: episode ?? this.episode,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'imgUrl': imgUrl,
      'countdown': countdown,
      'episode': episode,
      'slug': slug,
    };
  }

  factory CountdownModel.fromMap(Map<String, dynamic> map) {
    return CountdownModel(
      title: map['title'] as String,
      imgUrl: map['img_url'] as String,
      countdown: map['countdown'] as String,
      episode: map['episode'] as String,
      slug: map['slug'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountdownModel.fromJson(String source) =>
      CountdownModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CountdownModel(title: $title, imgUrl: $imgUrl, countdown: $countdown, episode: $episode, slug: $slug)';
  }
}
