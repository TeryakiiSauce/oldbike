class User {
  final _auth = Auth;
  final String username, firstName, lastName, email, gender, bloodGroup;
  final DateTime dob;
  final double weight, height;
  // final DateTime dateCreated, loginDate;

  const User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.bloodGroup,
    required this.dob,
    required this.height,
    required this.weight,
  });

  void createUser() {}
}
