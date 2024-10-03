class PokeModel {
  final String name;
  final String image;

  PokeModel({
    required this.name,
    required this.image,
  });

  factory PokeModel.fromJson(Map<String, dynamic> json) {
    return PokeModel(
      name: json['name'],
      image: json['sprites']['front_default']
    );
  }
}