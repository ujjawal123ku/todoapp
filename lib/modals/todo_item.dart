class TodoItem {
  String title;
  String description;

  TodoItem({required this.title, this.description = ''});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    title: json['title'],
    description: json['description'] ?? '',
  );
}
