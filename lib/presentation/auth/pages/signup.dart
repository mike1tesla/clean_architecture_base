import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_iot/common/widgets/appbar/app_bar.dart';
import 'package:smart_iot/common/widgets/button/basic_app_button.dart';
import 'package:smart_iot/core/configs/assets/app_vectors.dart';
import 'package:smart_iot/data/models/auth/create_user_req.dart';
import 'package:smart_iot/domain/usecase/auth/signup.dart';
import 'package:smart_iot/presentation/auth/pages/signin.dart';
import 'package:smart_iot/presentation/root/pages/root.dart';

import '../../../service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 20),
            _fullNameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SignupUseCase>().call(
                  params: CreateUserReq(
                    fullName: _fullName.text,
                    email: _email.text,
                    password: _password.text,
                  ),
                );
                result.fold(
                  (l) {
                    var snackBar = SnackBar(content: Text(l));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  (r) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const RootPage()),
                      (route) => false,
                    );
                  },
                );
              },
              title: "Create Account",
            ),
            const SizedBox(height: 50),
            _signinText(context),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text("Register", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold));
  }

  Widget _fullNameField(context) {
    return TextField(
      cursorColor: Colors.green,
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(context) {
    return TextField(
      cursorColor: Colors.green,
      controller: _email,
      decoration: const InputDecoration(
        hintText: "Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(context) {
    return TextField(
      cursorColor: Colors.green,
      controller: _password,
      decoration: const InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Do you have an account ? ",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
          child: const Text("Sign In",
              style: TextStyle(color: Color(0xFF278CE8), fontSize: 14, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
