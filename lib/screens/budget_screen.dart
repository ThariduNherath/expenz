import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:expenz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCatogoryTotals;
  final Map<IncomeCategory, double> incomeCatogoryTotals;
  const BudgetScreen({
    super.key,
    required this.expenseCatogoryTotals,
    required this.incomeCatogoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  // method to find color

  Color getcategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColor[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCatogoryTotals
        : widget.incomeCatogoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),

                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 1 ? kWhite : kRed,
                          ),

                          child: Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),

                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: _selectedOption == 1 ? kBlack : kWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 0 ? kWhite : kGreen,
                          ),

                          child: Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),

                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _selectedOption == 0 ? kBlack : kWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // pie chart
              Chart(
                expenseCatogoryotals: widget.expenseCatogoryTotals,
                incomeCatogoryTotals: widget.incomeCatogoryTotals,
                isExpense: _selectedOption == 0,
              ),

              SizedBox(height: 20),

              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,

                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      total: data.values.reduce((value, element) =>value + element ),
                      progressColor: getcategoryColor(category),
                      isExpense: _selectedOption == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
