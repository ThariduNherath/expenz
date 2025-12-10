import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  final List<ExpenseModel> expensesList;
  final List<Income> incomeList;

  final void Function(ExpenseModel) onDismissedExpense; 
  final void Function(Income) onDismissedIncome;


  const TransactionsScreen({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense, 
    required this.incomeList, required this.onDismissedIncome,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "See Your Finacial Report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainColor,
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 20),

              // show all the expenses
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                        widget.expensesList.isEmpty 
                        ? Text("No Expenses added yet, add some expenses to see here",
                        style: TextStyle(fontSize: 16,color: kGrey),
                        ):

                    
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.expensesList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expensesList[index];

                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedExpense(expense);
                              });
                            },
                            child: ExpenseCard(
                              title: expense.title,
                              date: expense.date,
                              amount: expense.amount,
                              category: expense.category,
                              description: expense.description,
                              time: expense.time,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
               Text(
                "Incomes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 20),

              // show all the expenses
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                        widget.incomeList.isEmpty 
                        ? Text("No Income added yet, add some expenses to see here",
                        style: TextStyle(fontSize: 16,color: kGrey),
                        ):
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.incomeList.length,
                        itemBuilder: (context, index) {
                          final income = widget.incomeList[index];

                          return Dismissible(
                            key: ValueKey(income),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedIncome(income);
                              });
                            },
                            child: IncomeCard(
                              title: income.title,
                              date: income.date,
                              amount: income.amount,
                              category: income.category,
                              description: income.description,
                              time: income.time,
                            ),
                         );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
