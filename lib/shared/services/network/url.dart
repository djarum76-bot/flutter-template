class Url {
  static const baseURL = "https://test.com/";

  static List<String> excludedPath = [
    user(UserEndpoint.register),
    user(UserEndpoint.login),
  ];

  static String user(UserEndpoint userEndpoint, {String? originPoint, String? destination}) {
    switch (userEndpoint) {
      case UserEndpoint.register:
        return "register";
      case UserEndpoint.login:
        return "login";
    }
  }
}

enum UserEndpoint { register, login }