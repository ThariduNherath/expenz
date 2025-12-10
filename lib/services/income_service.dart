import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  static const String _incomeKey = 'income';

  // save the income to shared prefrences

  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? exitingIncomes = prefs.getStringList(_incomeKey);

      // convert the exiting incomes to a list of income objects

      List<Income> exitingIncomeObjects = [];

      if (exitingIncomes != null) {
        exitingIncomeObjects = exitingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // add the new income to the list

      exitingIncomeObjects.add(income);

      // convert the list of income objects back to a list  od strings

      List<String> updatedIncome = exitingIncomeObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save the updated list of incomes to shared preferences

      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error adding Income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // load the income from shared prefrences

  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    // convert the existing incomes to a list of income obejects

    List<Income> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes = existingIncomes
          .map((e) => Income.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedIncomes;
  }
}
