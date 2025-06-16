class Document {
  int? id;
  String title;
  String description;
  String filePath;
  String fileType;
  DateTime createdAt;

  Document({
    this.id,
    required this.title,
    required this.description,
    required this.filePath,
    required this.fileType,
    required this.createdAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      filePath: json['file_path'],
      fileType: json['file_type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file_path': filePath,
      'file_type': fileType,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
