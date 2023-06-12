import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../misc/constants.dart';
import '../../../misc/validators.dart';
import '../../../services/helper_user.dart';
import '../../../services/user_service.dart';
import '../app_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBoxH30(),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.deepOrange.shade100,
                      Colors.white,
                      Colors.white
                    ]),
                borderRadius: BorderRadius.circular(90)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Sign up to get started',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          Focus(
            onFocusChange: (value) async {
              if (!value) {
                context
                    .read<UserService>()
                    .checkIfUserExists(emailController.text.trim());
              }
            },
            child: AppTextField(
              validate: validateEmail,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              labelText: 'Email',
            ),
          ),
          SizedBoxH10(),
          Selector<UserService, bool>(
            selector: (context, value) => value.userExists,
            builder: (context, value, child) {
              return value
                  ? Text('Email address already exists!',
                      style: appTextStyle(16, Colors.red, FontWeight.bold))
                  : Container();
            },
          ),
          AppTextField(
            validate: validateName,
            keyboardType: TextInputType.text,
            controller: nameController,
            labelText: 'Name',
          ),
          SizedBoxH10(),
          AppTextField(
            validate: validatePassword,
            hideText: true,
            keyboardType: TextInputType.text,
            controller: passwordController,
            labelText: 'Password',
          ),
          SizedBoxH10(),
          AppTextField(
            validate: validateConfirmPassword,
            hideText: true,
            keyboardType: TextInputType.text,
            controller: confirmPasswordController,
            labelText: 'Confirm password',
          ),
          SizedBoxH20(),
          CupertinoButton(
            alignment: Alignment.center,
            borderRadius: BorderRadius.circular(15),
            color: Colors.deepOrange,
            onPressed: () {
              createNewUserInUI(context,
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  name: nameController.text.trim(),
                  confirmPassword: confirmPasswordController.text.trim());
            },
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
