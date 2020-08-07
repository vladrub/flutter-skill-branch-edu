// import 'package:SkillBranchFlutter/models/user.dart';
import 'models/user.dart';

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

  User getUserByName(String fullName) {
    User user;
    users.forEach((String login, User u) {
      if (u.name == fullName) user = u;
    });
    return user;
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
    // User user = getUserByName(fullName);
    // if (user == null) throw Exception("A user with this name not found");

    User foundUser = getUserByLogin(fullName);
    if (foundUser == null) throw Exception("A user with this name not found");

    User friend = foundUser.findFriend(user);
    if (friend == null)
      throw Exception("${user.login} is not a friend of the login");

    return friend;
  }

  void setFriends(String login, List friends) {
    users[login].friends = friends;
  }

  List<User> importUsers(List<String> csv) {
    List<User> importedUsers = [];

    csv.forEach((element) {
      List splitted = element.split(";");
      importedUsers.add(User(
        name: splitted[0].trim(),
        email: splitted[1].trim(),
        phone: splitted[2].trim(),
      ));
    });

    return importedUsers;
  }
}
