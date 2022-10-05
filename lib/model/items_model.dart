class ItemsModel {
  final String title;
  final int id;
  ItemsModel({
    required this.title,
    required this.id,
  });
  factory ItemsModel.fromMap(Map<String, dynamic> json) => ItemsModel(
    title: json['title'],
    id: json['id'],
  );
  Map<String, dynamic> toMap() => {
    'title': title,
    'id': id,
  };
}