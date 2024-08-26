class UserModel {
  final String? id;
  final String? role;
  final String? email;
  final String? password;

  const UserModel({
    this.id,
    this.role,
    this.email,
    this.password,
  });

  toJson() {
    return {
      'id': id,
      'role': role,
      'email': email,
      'password': password,
    };
  }
  
}