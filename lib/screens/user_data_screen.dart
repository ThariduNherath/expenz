import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  // for the checkbox 

  bool _rememberMe = false;


  // form key for the form validation

  final _formKey = GlobalKey<FormState>();

  // controllers for the form fields

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  void dispose() {
   _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Personal Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 30),

                //form
                Form(

                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // form fields
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {

                          // check weather the user entered
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                          
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),

                      SizedBox(height: 15),

                      // form fields  Email
                      TextFormField(
                        
                        controller: _emailController,
                          validator: (value) {

                          // check weather the user entered
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                          
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),
                      // form fields  password
                      TextFormField(
                        controller: _passwordController,
                          validator: (value) {

                          // check weather the user entered
                          if (value!.isEmpty) {
                            return 'Please enter valid password';
                          }
                          return null;
                          
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _confirmPasswordController,
                          validator: (value) {

                          // check weather the user entered
                          if (value!.isEmpty) {
                            return 'Please enter the same password';
                          }
                          return null;
                          
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),

                      //rememeber me for the next time
                      Row(
                        children: [
                          
                          Text(
                            "Remember me for the next time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kGrey,

                            ),
                          ),
                          Expanded(child: CheckboxListTile(
                            activeColor: kMainColor,
                            value: _rememberMe ,
                          onChanged: (value) {
                            
                            setState(() {
                              _rememberMe = value!;
                            },
                            
                            );
                          },
                          ),
                          
                          ),
                            
                    
                        ],
                      ),

                       SizedBox(height: 30,),

                     // Sunmit button

                     GestureDetector(
                      onTap: ()async {
                        
                        if(_formKey.currentState!.validate()) {
                          // form is valid, proceed further
                          String userName = _userNameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          String confirmPassword = _confirmPasswordController.text;
                          
                          // save the user name and email in the device storage

                           await UserService.storeUserDetails(
                            userName: userName,
                            email: email,
                            password: password,
                            confirmPassword: confirmPassword,
                            context: context,
                           );

                           // navigate to the main screen

                           if(context.mounted) {
                             Navigator.push(context, MaterialPageRoute(builder: (context){

                              return const MainScreen();
                            }));
                           }


                        }
                      },
                      child: CustomButton(buttonName: "Next", buttonColor: kMainColor))


                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
