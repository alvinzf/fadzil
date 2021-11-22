class Chara {
  final int id;
  final String name;
  final String vision;
  final String weapon;
  final String nation;
  final String affiliation;
  final int rarity;
  final String constellation;
  final String birthday;
  final String description;
  final String images;

  Chara(
      {required this.id,
      required this.name,
      required this.vision,
      required this.weapon,
      required this.nation,
      required this.affiliation,
      required this.rarity,
      required this.constellation,
      required this.birthday,
      required this.description,
      required this.images});

  factory Chara.fromJson(Map<String, dynamic> json) {
    return Chara(
      id: json['id'] as int,
      name: json['name'] as String,
      vision: json['vision'] as String,
      weapon: json['weapon'] as String,
      nation: json['nation'] as String,
      affiliation: json['affiliation'] as String,
      rarity: json['rarity'] as int,
      constellation: json['constellation'] as String,
      birthday: json['birthday'] as String,
      description: json['description'] as String,
      images: json['images'] as String,
    );
  }
}
