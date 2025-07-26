import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:go_router/go_router.dart';
import 'app_color.dart';
import 'design_button.dart';
import 'design_textfield.dart';
import 'loading_dialog.dart';


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
  // dummy account
  String validEmail = "aman@gmail.com";
  String validPassword = "123456";

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  /// rive controller and input
  StateMachineController? controller;

  // SMI Stand for State Machine Input
  SMIBool? lookOnEmail;
  SMINumber? followOnEmail;

  SMIBool? lookOnPassword;
  SMIBool? peekOnPassword;

  SMITrigger? triggerSuccess;
  SMITrigger? triggerFail;

  // New variables for login status
  bool isLoginSuccess = false; // To track the login state
  bool isContainerVisible = false; // To control the visibility of the result container

  @override
  void initState() {
    emailFocusNode.addListener(() {
      lookOnEmail?.change(emailFocusNode.hasFocus);
    });

    passwordFocusNode.addListener(() {
      lookOnPassword?.change(passwordFocusNode.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();

    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 86),
            Text(
              "Rive + Flutter \nAnimated Guardian \nPolar Bear",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Visibility(
              visible: isContainerVisible,
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isLoginSuccess ? AppColor.success[700] : AppColor.danger[500] ,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isLoginSuccess ? "Login Successful" : "Login Failed",
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: RiveAnimation.asset(
                "assets/animation/auth_teddy.riv",
                fit: BoxFit.fitHeight,
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login Machine",
                  );

                  if (controller == null) return;
                  artboard.addController(controller!);

                  lookOnEmail = controller?.getBoolInput("isFocus");
                  followOnEmail = controller?.getNumberInput("numLook");
                  lookOnPassword = controller?.getBoolInput("isPrivateField");
                  peekOnPassword = controller?.getBoolInput(
                    "isPrivateFieldShow",
                  );
                  triggerSuccess = controller?.getTriggerInput(
                    "successTrigger",
                  );
                  triggerFail = controller?.getTriggerInput("failTrigger");
                },
              ),
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
                    focusNode: emailFocusNode,
                    textEditingController: emailController,
                    labelText: "Email",
                    hintText: "Enter your email..",
                    onChanged: (value) {
                      followOnEmail?.change(value.length * 1.5);
                    },
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  DesignTextfield(
                    obscureText: true,
                    focusNode: passwordFocusNode,
                    textEditingController: passwordController,
                    maxLines: 1,
                    labelText: "Password",
                    hintText: "Enter your password..",
                    onHideText: (hide) {
                      passwordFocusNode.requestFocus();
                      peekOnPassword?.change(!hide);
                    },
                  ),
                  const SizedBox(height: 32),
                  DesignButton(
                    text: "Login",
                    size: DesignButtonSize.large,
                    onPressed: onCLickLogin,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCLickLogin() async {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    showLoadingDialog(context);

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    GoRouter.of(context).pop();

    final valid =
        email.toLowerCase() == validEmail.toLowerCase() &&
            password == validPassword;

    // Update the login result and show the container
    setState(() {
      isLoginSuccess = valid;
      isContainerVisible = true;
    });

    if (valid) {
      triggerSuccess?.change(true);
    } else {
      triggerFail?.change(true);
    }
  }
}

