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
    if (json['id'] == null ||
        json['title'] == null ||
        json['file_path'] == null) {
      throw FormatException('Invalid document data: missing required fields');
    }
    return Document(
      id: int.parse(json['id'].toString()),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      filePath: json['file_path'] as String,
      fileType: json['file_type'] as String? ?? 'unknown',
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
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
