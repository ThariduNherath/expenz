import 'package:expenz/constants/colors.dart';
import 'package:expenz/screens/add_new_screens.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // current page index

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    // screen list

    final List<Widget> pages = [

      HomeScreen(),
      TransactionsScreen(),
      AddNewScreen(),
      BudgetScreen(),
      ProfileScreen(),


      
    ];
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index){
          setState(() {
            _currentPageIndex = index;
         

          });
        },

        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),

        
        items: 
      
      [

        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
         BottomNavigationBarItem(icon: Icon(Icons.list_rounded), label: "Transactions"),
         BottomNavigationBarItem(
          
          icon: Container(
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(

              color: kMainColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add,color: kWhite,size: 30,),
            
            ),
            label: ""
            
            ),
              BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]
      
      ),

      body: pages[_currentPageIndex] ,
    );
  }
}