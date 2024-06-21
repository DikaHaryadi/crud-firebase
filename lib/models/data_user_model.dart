import 'package:cloud_firestore/cloud_firestore.dart';

class DataUserModel {
  String id;
  String photoUser;
  String userName;
  String password;
  String namaUser;
  String umur;
  String agama;
  String jenisKelamin;
  String pendidikan;
  String alamat;
  // final DocumentSnapshot? documentSnapshot;

  DataUserModel({
    this.id = '',
    required this.photoUser,
    required this.userName,
    required this.password,
    required this.namaUser,
    required this.umur,
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
        umur: '',
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
      'umur': umur,
      'agama': agama,
      'jenisKelamin': jenisKelamin,
      'pendidikan': pendidikan,
      'alamat': alamat,
    };
  }

  factory DataUserModel.fromSnapshot(QueryDocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return DataUserModel(
      id: document.id,
      photoUser: data['photoUser'] ?? '',
      userName: data['userName'] ?? '',
      password: data['password'] ?? '',
      namaUser: data['namaUser'] ?? '',
      umur: data['umur'] ?? '',
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
      'umur': umur,
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
