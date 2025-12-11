import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCatogoryotals;
  final Map<IncomeCategory, double> incomeCatogoryTotals;

  final bool isExpense;
  const Chart({
    super.key,

    required this.isExpense,
    required this.expenseCatogoryotals,
    required this.incomeCatogoryTotals,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  // section data

  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.food],
          value: widget.expenseCatogoryotals[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.health],
          value: widget.expenseCatogoryotals[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.shopping],
          value: widget.expenseCatogoryotals[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.subscription],
          value: widget.expenseCatogoryotals[ExpenseCategory.subscription] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.transport],
          value: widget.expenseCatogoryotals[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.freelance],
          value: widget.incomeCatogoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),

        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.passive],
          value: widget.incomeCatogoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),

        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.salary],
          value: widget.incomeCatogoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),

        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.sales],
          value: widget.incomeCatogoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(


      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(


      height: 250,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(

        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(

        alignment: Alignment.center,

        children: [

          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text("70%",style: TextStyle(color: kBlack,
              fontWeight: FontWeight.bold,
              
              ),
              ),

              SizedBox(

                height: 8,
              ),
              Text("of 100%",style: TextStyle(

                color: kGrey
              ),
              
              ),

             
            ],
          )


        ],
      ),
    );
  }
}
