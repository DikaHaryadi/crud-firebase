import 'package:cloud_firestore/cloud_firestore.dart';

class AgamaModel {
  String agamaId;
  String agama;

  AgamaModel({required this.agamaId, required this.agama});

  Map<String, dynamic> toJson() {
    return {
      'agama': agama,
    };
  }

  factory AgamaModel.fromSnapshot(DocumentSnapshot doc) {
    return AgamaModel(
      agamaId: doc.id, // The document ID from Firestore
      agama: doc.get('agama') ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'agama': agama};
  }
}
