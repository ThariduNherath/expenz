import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/Line_chart.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_expense_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<ExpenseModel> expenseList;
  final List<Income> incomeList;

  const HomeScreen({
    super.key,
    required this.expenseList,  
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // for store the user name

  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    // get the username from the shared pref

    UserService.getUserData().then((value) {
      if (value['userName'] != null) {
        setState(() {
          userName = value['userName']!;
        });
      }
    });

    setState(() {
      // total amount of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal += widget.expenseList[i].amount;
      }

      //total amount of incomes
      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // main column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kMainColor,
                              border: Border.all(color: kMainColor, width: 3),
                              borderRadius: BorderRadius.circular(100),
                            ),

                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          SizedBox(width: 20),
                          Text(
                            "Welcome  $userName",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(width: 20),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenseCard(
                            title: "Income",
                            amount: incomeTotal,
                            imageUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IncomeExpenseCard(
                            title: "Expense",
                            amount: expenseTotal,
                            imageUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //line chart
              Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Spend Frequianzy",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),

                    LineChartSample(),
                  ],
                ),
              ),

              //recent transactions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 20),

                    Column(
                      children: [
                        widget.expenseList.isEmpty
                            ? Text(
                                "No Expenses added yet, add some expenses to see here",
                                style: TextStyle(fontSize: 16, color: kGrey),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.expenseList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expenseList[index];

                                  return ExpenseCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount,
                                    category: expense.category,
                                    description: expense.description,
                                    time: expense.time,
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
