import 'package:marvel_universe/core/extensions/list.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';

class CharactersResponse {
  int code;
  String status;
  Data data;

  CharactersResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      code: json['code'],
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<CharacterResponse> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      results: List<CharacterResponse>.from(
          json['results'].map((x) => CharacterResponse.fromJson(x))),
    );
  }
}

class CharacterResponse extends Character {
  const CharacterResponse({
    required int id,
    required String name,
    required String description,
    required String modified,
    required Thumbnail thumbnail,
    required List<Url> urls,
    required String image,
    String? wikiUrl,
    String? comicLink,
    String? detailLink,
  }) : super(
          id: id,
          name: name,
          image: image,
          description: description,
          wikiUrl: wikiUrl,
          comicLink: comicLink,
          detailLink: detailLink,
        );

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    final thumbnail = Thumbnail.fromJson(json['thumbnail']);
    final List<Url> urls =
        List<Url>.from(json['urls'].map((x) => Url.fromJson(x)));
    final image = '${thumbnail.path}.${thumbnail.extension}';

    return CharacterResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      modified: json['modified'],
      thumbnail: thumbnail,
      urls: urls,
      image: image,
      wikiUrl: urls.firstWhereOrNull((url) => url.type == 'wiki')?.url,
      comicLink: urls.firstWhereOrNull((url) => url.type == 'comiclink')?.url,
      detailLink: urls.firstWhereOrNull((url) => url.type == 'detail')?.url,
    );
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json['path'],
      extension: json['extension'],
    );
  }
}

class Url {
  String type;
  String url;

  Url({
    required this.type,
    required this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'],
      url: json['url'],
    );
  }
}
