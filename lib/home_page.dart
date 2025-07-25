import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';
import 'design_button.dart';
import 'design_textfield.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeUI();
  }
}

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 86),
            Text("Animated Guardian \nPolar Bear",
            style: Theme.of (context,
            ).textTheme.headlineMedium?.copyWith(color:AppColor.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 300,
              width: 300,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DesignTextfield(
                    labelText: "Email",
                    hintText: "Enter your email..",
                    onChanged: (value){},
                    maxLines: 1,
                  ),
                  DesignTextfield(
                    obscureText: true,
                    maxLines: 1,
                    labelText: "Password",
                    hintText: "Enter your password..",
                    onChanged: (hide){},
                  ),
                  const SizedBox(height: 32),
                  DesignButton(
                    text: "Login",
                    size: DesignButtonSize.large,
                  ),
                ],

              ),
            )
          ],
        ),

      ),
    );
  }
}

