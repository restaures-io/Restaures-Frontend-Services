class User {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final List<String>? notificationPreferences;
  final String userType; // 'customer' or 'restaurant'

  User({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    this.notificationPreferences,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      notificationPreferences: json['notificationPreferences'] != null
          ? List<String>.from(json['notificationPreferences'])
          : null,
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'notificationPreferences': notificationPreferences,
      'userType': userType,
    };
  }
}

