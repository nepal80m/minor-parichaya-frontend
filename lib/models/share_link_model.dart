import 'document_model.dart';

class ShareLink {
  int? id;
  String title;
  String serverId;
  String encryptionkey;
  DateTime createdOn;
  String expiryDate;
  List<Document> documents;

  ShareLink(
      {this.id,
      required this.title,
      required this.serverId,
      required this.createdOn,
      required this.expiryDate,
      required this.documents,
      required this.encryptionkey});
}
