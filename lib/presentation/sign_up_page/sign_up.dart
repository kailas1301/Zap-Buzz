import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';
import 'package:zapbuzz/services/auth_gate/auth_gate.dart';
import 'package:zapbuzz/presentation/login/login_page.dart';
import 'package:zapbuzz/services/auth/auth_services.dart';
import 'package:zapbuzz/utils/widgets/elevatedbutton_widget.dart';
import 'package:zapbuzz/utils/widgets/textformfield_widget.dart';
import 'package:zapbuzz/utils/widgets/textwidgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void signUpWithEmail() async {
      final authService = Provider.of<AuthServices>(context, listen: false);
      try {
        await authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthGate(),
            ),
            (route) => false);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // App logo
              ClipRect(
                child: Image.asset(
                    'assets/images/logo.png'), // Ensure you have the correct path
              ),
              const SizedBox(height: 20),
              const SubHeadingTextWidget(
                title: "Come Join Us",
                textsize: 18,
                textColor: kAppPrimaryColor,
              ),
              kSizedBoxH20,
              // TextFormField for email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldWidget(
                  labelText: "E-mail",
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  prefixIcon: Icons.email,
                ),
              ),
              kSizedBoxH20, // TextFormField for password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldWidget(
                  labelText: "Password",
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
              ),
              kSizedBoxH20,
              // TextFormField for confirm password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldWidget(
                  labelText: "Password",
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
              ),
              kSizedBoxH20,
              // Button for sign up
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButtonWidget(
                  buttonText: 'Sign Up',
                  width: 170,
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;
                    if (password == confirmPassword &&
                        password.isNotEmpty &&
                        email.isNotEmpty) {
                      signUpWithEmail();
                    } else {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Text to navigate to the login screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
