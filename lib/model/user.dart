class User {
  final String token;
  final String refreshToken;

  final String userId;
  final String fullName;
  final String email;
  final bool isEmailVerified;
  final String phoneNumber;
  final bool isPhoneVerified;
  final String dob;
  final String gender;
  final String city;
  final String country;
  final String photo;

  User({
    this.token,
    this.refreshToken,
    this.userId,
    this.fullName,
    this.email,
    this.isEmailVerified,
    this.phoneNumber,
    this.isPhoneVerified,
    this.dob,
    this.gender,
    this.city,
    this.country,
    this.photo,
  });

  factory User.fromJSON(var json) {
    return User(
      token: json['token'],
      userId: json['userId'],
      refreshToken: json['refreshToken'],
      fullName: json['cust_fullName'],
      email: json['cust_email'],
      isEmailVerified: json['isEmailVerified'],
      phoneNumber: json['cust_phone'],
      isPhoneVerified: json['isPhoneVerified'],
      dob: json['cust_dob'],
      gender: json['cust_gender'],
      city: json['cust_city'],
      country: json['cust_country'],
      photo: json['cust_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "userId": userId,
      "refreshToken": refreshToken,
      "cust_fullName": fullName,
      "cust_email": email,
      "isEmailVerified": isEmailVerified,
      "cust_phone": phoneNumber,
      "isPhoneVerified": isPhoneVerified,
      "cust_dob": dob,
      "cust_gender": gender,
      "cust_city": city,
      "cust_country": country,
      "cust_photo": photo,
    };
  }
}
