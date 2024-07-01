class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String gender;
  final String occupation;
  final String pincode;
  final String city;
  final String state;
  final String imageUrl;

  ProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.occupation,
    required this.pincode,
    required this.city,
    required this.state,
    required this.imageUrl,
  });

  factory ProfileModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return ProfileModel(
        uid: '',
        name: '',
        email: '',
        phoneNumber: '',
        gender: '',
        occupation: '',
        pincode: '',
        city: '',
        state: '',
        imageUrl: '',
      );
    }
    return ProfileModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      gender: map['gender'] ?? '',
      occupation: map['occupation'] ?? '',
      pincode: map['pincode'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }
}
