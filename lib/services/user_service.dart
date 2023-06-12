import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:backendless_todo_starter/models/unit_entry.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  //initialize backendless user
  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  //set current user to null
  void setCurrentUserToNull() {
    _currentUser = null;
  }

  //check data if user exists
  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

//show progress to the user with text
  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  //reset user password
  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Resetting password...';
    notifyListeners();
    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  //log in the user
  Future<String> loginUser(String username, String password) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = "Logging in...";
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    if (user != null) {
      _currentUser = user;
    }
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  //log out the user
  Future<String> logoutUser() async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Logging out...';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  //check if the user is logged in
  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (validLogin != null && validLogin) {
      String? currentObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });

      if (currentObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentObjectId)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  //check if the user already exist
  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  //create a new user
  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating account...';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      UnitEntry emptyEntry = UnitEntry(units: {}, username: user.email);

      await Backendless.data
          .of('UnitEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }
}

//error messages
String getError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}
