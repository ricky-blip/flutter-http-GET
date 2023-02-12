class UserModel {
  final String nama;
  final String kota;
  final String id;

  const UserModel({
    required this.nama,
    required this.kota,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nama: json['nama'],
      kota: json['kota'],
      id: json['id'],
    );
  }
}
