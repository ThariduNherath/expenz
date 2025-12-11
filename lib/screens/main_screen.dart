import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screens.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:expenz/services/expence_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<ExpenseModel> expenseList = [];
  List<Income> incomeList = [];

  @override
  void initState() {
    super.initState();
    fetchAllExpenses();
    fetchAllIncomes();
  }

  // Fetch all expenses
  void fetchAllExpenses() async {
    List<ExpenseModel> loadedExpenses = await ExpenceService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print("Expenses loaded: ${expenseList.length}");
    });
  }

  // Fetch all incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
      print("Incomes loaded: ${incomeList.length}");
    });
  }

  // Add new expense
  void addNewExpense(ExpenseModel newExpense) {
    ExpenceService().saveExpenses(newExpense, context);
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // Add new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // Remove expense
  void removeExpense(ExpenseModel expense) {
    ExpenceService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  // Remove income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  // Calculate total expenses per category
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotals = {
      for (var cat in ExpenseCategory.values) cat: 0.0,
    };

    for (ExpenseModel expense in expenseList) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    return categoryTotals;
  }

  // Calculate total incomes per category
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      for (var cat in IncomeCategory.values) cat: 0.0,
    };

    for (Income income in incomeList) {
      categoryTotals[income.category] =
          (categoryTotals[income.category] ?? 0) + income.amount;
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(expenseList: expenseList, incomeList: incomeList),
      TransactionsScreen(
        expensesList: expenseList,
        incomeList: incomeList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(
        expenseCatogoryTotals: calculateExpenseCategories(),
        incomeCatogoryTotals: calculateIncomeCategories(),
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.list_rounded), label: "Transactions"),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: kWhite, size: 30),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
