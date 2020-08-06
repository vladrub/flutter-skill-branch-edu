import 'package:SkillBranchFlutter/models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    // User user2 = User(name: 'asd asd', phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists");
    }

    // print(user == user2);
    // print(user2.toString());
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  User registerUserByPhone(String name, String phone) {
    User user = User(name: name, phone: phone, email: "");

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this phone already exists");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email, phone: "");

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this email already exists");
    }
  }

  User findUserInFriends(String fullName, User user) {
    print(user.friends);
  }

  void setFriends(String login, List friends) {
    users[login].friends = friends;
  }
}
