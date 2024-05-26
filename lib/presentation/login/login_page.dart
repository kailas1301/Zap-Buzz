import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapbuzz/presentation/sign_up_page/sign_up.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';
import 'package:zapbuzz/services/auth/auth_services.dart';
import 'package:zapbuzz/utils/widgets/elevatedbutton_widget.dart';
import 'package:zapbuzz/utils/widgets/textformfield_widget.dart';
import 'package:zapbuzz/utils/widgets/textwidgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              kSizedBoxH30,
              kSizedBoxH30,
              // App logo
              ClipRect(
                child: Image.asset(
                    'assets/images/logo.png'), // Ensure you have the correct path
              ),
              kSizedBoxH20,
              const SubHeadingTextWidget(
                title: "Welcome Back to Zap Buzz",
                textColor: kAppPrimaryColor,
                textsize: 18,
              ),
              kSizedBoxH30,
              // TextFormField for email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldWidget(
                    labelText: 'E-mail',
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: Icons.email),
              ),
              const SizedBox(height: 20),
              // TextFormField for password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldWidget(
                    labelText: 'Password',
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.lock),
              ),
              kSizedBoxH30,
              // Button for log in
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButtonWidget(
                  width: 170,
                  buttonText: 'Log In',
                  onPressed: () {
                    signIn(
                        context, emailController.text, passwordController.text);
                  },
                ),
              ),
              kSizedBoxH20,
              // Text to create a new account
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text('Create a new account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class TextFormFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   final Icon prefixIcon;
//   final TextInputType keyBoardType;

//   const TextFormFieldWidget({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     required this.prefixIcon,
//     required this.keyBoardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: keyBoardType,
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         fillColor: primaryKcolor,
//         prefixIcon: prefixIcon,
//         hintText: hintText,
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide.none,
//         ),
//         disabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

void signIn(BuildContext context, String email, String password) async {
  final authService = Provider.of<AuthServices>(context, listen: false);
  try {
    await authService.logInWithEmail(email, password);
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
