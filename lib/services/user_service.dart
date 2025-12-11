import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // method to store the user name and user email shared prefrences

  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    // if the user password and conffirm password are same then store users name and email
    try {
      // check weather the user enterd password are the same
      if (password != confirmPassword) {
        // show a massage to the user
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("passwords do not match")));

        return;
      }

      // create a instance from shared prefrencess

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // store the user name and email as key value pair

      await prefs.setString('userName', userName);
      await prefs.setString('email', email);

      // show a massage to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User details saved successfully")),
      );
    } catch (err) {
      err.toString();
    }
  }

  // method to check weather username is saved in the shared pref

  static Future<bool> checkUserName() async {
    // create a instance from shared prefrencess
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    return userName != null;
  }

  // get the user name and email

  static Future<Map<String, String?>> getUserData() async {
    // create a instance from shared prefrencess
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    String? email = prefs.getString('email');

    return {'userName': userName!, 'email': email!};
  }

  // remove the username and email from prefrences

  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('username');
    await pref.remove('email');
  }
}
