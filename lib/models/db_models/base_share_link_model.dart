class BaseShareLink {
  int? id;
  String serverId;
  String title;
  String encryptionKey;

  BaseShareLink({
    this.id,
    required this.serverId,
    required this.title,
    required this.encryptionKey,
  });

  factory BaseShareLink.fromMap(Map<String, dynamic> map) => BaseShareLink(
        id: map['id'],
        serverId: map['serverId'],
        title: map['title'],
        encryptionKey: map['encryptionKey'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'serverId': serverId,
        'title': title,
        'encryptionKey': encryptionKey,
      };

  @override
  String toString() {
    return 'BaseShareLink(id: $id, serverId: $serverId, title: $title, encryptionKey: $encryptionKey)';
  }
}
