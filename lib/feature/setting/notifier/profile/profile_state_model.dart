class ProfileStateModel {
  final String? name, id, email, token;

  ProfileStateModel({
    this.name,
    this.id,
    this.email,
    this.token,
  });
  ProfileStateModel copyWith({
    String? name,
    email,
    id,
    token,
  }) {
    return ProfileStateModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
