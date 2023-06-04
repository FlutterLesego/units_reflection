import 'package:backendless_todo_starter/misc/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../misc/constants.dart';
import '../../../routes/routes.dart';
import '../../../services/helper_user.dart';
import '../app_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
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
                  'Welcome,',
                  style: appTextStyle(30, Colors.black, FontWeight.bold),
                ),
                Text(
                  'Sign in to continue!',
                  style: appTextStyle(
                      16, Colors.black.withOpacity(0.7), FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          AppTextField(
            preIcon: Icon(
              Icons.email_outlined,
              color: Colors.deepOrange,
            ),
            validate: validateEmail,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            labelText: 'Email',
          ),
          SizedBoxH10(),
          AppTextField(
            preIcon: Icon(
              Icons.lock_outline,
              color: Colors.deepOrange,
            ),
            validate: validatePassword,
            hideText: true,
            keyboardType: TextInputType.text,
            controller: passwordController,
            labelText: 'Password',
          ),
          SizedBoxH10(),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                resetPasswordInUI(context, email: emailController.text.trim());
              },
              child: Text('Reset password',
                  style: appTextStyle(16, Colors.black, FontWeight.w300)),
            ),
          ),
          SizedBoxH30(),
          CupertinoButton(
              alignment: Alignment.center,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(15),
              onPressed: () {
                loginUserInUI(context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
              },
              child: Text(
                'Sign in',
                style: appTextStyle(18, Colors.white, FontWeight.w400),
              )),
          SizedBoxH30(),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.registerPage);
                },
                child: RichText(
                    text: TextSpan(
                        text: 'New user? ',
                        style: appTextStyle(14, Colors.black, FontWeight.w300),
                        children: [
                      TextSpan(
                          text: ' Sign up',
                          style: appTextStyle(
                              14, Colors.deepOrange, FontWeight.bold))
                    ]))),
          )
        ],
      ),
    );
  }
}
