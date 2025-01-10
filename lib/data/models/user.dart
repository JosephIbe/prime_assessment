class User {
  String id;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  bool? verifiedEmail;
  DateTime updatedAt;
  String? phoneNumber;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.verifiedEmail,
    required this.updatedAt,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    createdAt: DateTime.parse(json["createdAt"]),
    verifiedEmail: json["verifiedEmail"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    phoneNumber: json["phoneNumber"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "verifiedEmail": verifiedEmail,
    "updatedAt": updatedAt.toIso8601String(),
    "phoneNumber": phoneNumber,
  };
}