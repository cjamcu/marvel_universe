import 'package:equatable/equatable.dart';

class CharactersInfo extends Equatable {
  final int totalElements;
  final List<Character> characters;
  final int totalPages;

  const CharactersInfo({
    required this.totalElements,
    required this.characters,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [totalElements, characters, totalPages];
}

class Character extends Equatable {
  final int id;
  final String name;
  final String image;
  final String? description;
  final String? wikiUrl;
  final String? comicLink;
  final String? detailLink;

  const Character({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    this.wikiUrl,
    this.comicLink,
    this.detailLink,
  });

  @override
  List<Object?> get props => [id, name, image, description];
}
