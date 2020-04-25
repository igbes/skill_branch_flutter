import 'models/user.dart';


class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("User with this name already exists");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this email already exists");
    }
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this phone already exists");
    }
  }

  User getUserByLogin(String login) {
    for (var value in users.values) {
      if (value.login == login) {
        return value;
      }
    }
    return null;
  }

  void setFriends(String login, List<User> friends) {
    getUserByLogin(login).addFriend(friends);
  }

  User findUserInFriends(String login, User user) {
    List<User> friends = getUserByLogin(login).friends;
    for (User data in friends) {
      if (data == user) return user;
    }
    throw Exception("${user.login} is not a friend of the login");
  }

  List<User> importUsers(List<String> stringUser) {
    List<User> listUser = <User>[];

    for (String data in stringUser) {
      List<String> userString = data.split(";\n");
      String name = userString[0].substring(6);
      String email = userString[1].substring(6);
      String phone = userString[2].substring(6);

      User user = User(name: name, email: email, phone: phone);
      listUser.add(user);
    }
    return listUser;
  }
}