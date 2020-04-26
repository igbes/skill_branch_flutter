import '../string_utils.dart';

enum LoginType { email, phone }

mixin UserUtils {
 
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}

class User with UserUtils{
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (phone == null)
      return User._(
        firstName: _getfirstName(name),
        lastName: _getLastName(name),
        email: checkEmail(email),
      );
    if (email == null)
      return User._(
        firstName: _getfirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
      );
    if (name.isEmpty) throw Exception("User name is empty!");
    if (email.isEmpty || phone.isEmpty)
      throw Exception("phone or email name is empty!");

    return User._(
      firstName: _getfirstName(name),
      lastName: _getLastName(name),
      phone: checkPhone(phone),
      email: checkEmail(email),
    );
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getfirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty f");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containting 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    // String pattern = r"^(?:+0])?[0-9]{11}";
    // phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    } else if (!email.contains('@')) {
      throw Exception("Enter a valid an email");
    }
    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  // String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";
   String get name => "${capitalize(_firstName)} ${capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (email == object.email || phone == object.phone);
    }
  }

  void addFriend(Iterable<User> newFrend) {
    friends.addAll(newFrend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()} 
   ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()} 
   ''';
  }
}

