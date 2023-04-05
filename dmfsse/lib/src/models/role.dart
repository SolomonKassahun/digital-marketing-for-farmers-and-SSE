class Role {
  List<String> roles;
  Role({required this.roles});
  Map<String, dynamic> tojson() => {"role": roles};
  Role.fromJson(Map<String, dynamic> json) : roles = json['roles'];
}
