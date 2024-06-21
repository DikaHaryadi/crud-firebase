import 'package:cloud_firestore/cloud_firestore.dart';

class DataUserModel {
  String photoUser;
  String userName;
  String password;
  String namaUser;
  String userId;
  String agama;
  String jenisKelamin;
  String pendidikan;
  String alamat;
  // final DocumentSnapshot? documentSnapshot;

  DataUserModel({
    required this.photoUser,
    required this.userName,
    required this.password,
    required this.namaUser,
    required this.userId,
    required this.agama,
    required this.jenisKelamin,
    required this.pendidikan,
    required this.alamat,
    // this.documentSnapshot,
  });

  static DataUserModel empty() => DataUserModel(
        photoUser: '',
        userName: '',
        password: '',
        namaUser: '',
        userId: '',
        agama: '',
        jenisKelamin: '',
        pendidikan: '',
        alamat: '',
        // documentSnapshot: null
      );

  Map<String, dynamic> toJson() {
    return {
      'photoUser': photoUser,
      'userName': userName,
      'password': password,
      'namaUser': namaUser,
      'userId': userId,
      'agama': agama,
      'jenisKelamin': jenisKelamin,
      'pendidikan': pendidikan,
      'alamat': alamat,
    };
  }

  factory DataUserModel.fromSnapshot(QueryDocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return DataUserModel(
      photoUser: data['photoUser'] ?? '',
      userName: data['userName'] ?? '',
      password: data['password'] ?? '',
      namaUser: data['namaUser'] ?? '',
      userId: data['userId'] ?? '',
      agama: data['agama'] ?? '',
      jenisKelamin: data['jenisKelamin'] ?? '',
      pendidikan: data['pendidikan'] ?? '',
      alamat: data['alamat'] ?? '',
      // documentSnapshot: document,
    );
  }

  // Method to convert DataUserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'password': password,
      'namaUser': namaUser,
      'agama': agama,
      'jenisKelamin': jenisKelamin,
      'pendidikan': pendidikan,
      'alamat': alamat,
      'photoUser': photoUser,
      // Add other fields as necessary
    };
  }
}
