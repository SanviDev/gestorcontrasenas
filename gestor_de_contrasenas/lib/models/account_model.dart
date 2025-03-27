class Account {
  String name;
  String user;
  String password;
  String email;
  String phone;

  Account(
      {
      required this.name,
      required this.user,
      required this.password,
      required this.email,
      required this.phone});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        name: json['name'],
        user: json['user'],
        password: json['password'],
        email: json['email'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name,'user': user, 'password': password, 'email': email, 'phone': phone};
  }
}
