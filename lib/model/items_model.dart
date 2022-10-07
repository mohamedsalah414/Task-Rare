class ItemsModel {
  final String title;
   int? id;
  ItemsModel({
    required this.title,
     this.id,
  });
  factory ItemsModel.fromMap(Map<String, dynamic> json) => ItemsModel(
    title: json['title'],
    id: json['id'],
  );
  Map<String, dynamic> toMap() => {
    'title': title,
  };
}