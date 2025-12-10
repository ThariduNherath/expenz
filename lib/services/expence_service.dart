import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenceService {
  // expense list

  List<ExpenseModel> expensList = [];

  //Define the key for storing expenses in shared prefrences

  static const String _expenseKey = 'expenses';

  // save the expenses to shared prefrences
  Future<void> saveExpenses(ExpenseModel expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //Convert the exiting expenses to a list of expenses objects

      List<ExpenseModel> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => ExpenseModel.fromJSON(json.decode(e)))
            .toList();
      }

      // add new expense to the list
      existingExpenseObjects.add(expense);

      // convert the list of expenses objects back to list of strings

      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save the update list of expenses to shared prefrences

      await prefs.setStringList(_expenseKey, updatedExpenses);
      // show massage

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expenses added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding Expenses!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Load the expenses from shared the prefrences

  Future<List<ExpenseModel>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? exitingExpenses = pref.getStringList(_expenseKey);

    // convert the exiting expenses to a list of Expenses objects

    List<ExpenseModel> loadedExpenses = [];

    if (exitingExpenses != null) {
      loadedExpenses = exitingExpenses
          .map((e) => ExpenseModel.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }
}
