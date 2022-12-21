import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/popup_alerts.dart';
import 'package:oldbike/utils/text_styles.dart';

class CustomUserInfoForm extends StatefulWidget {
  final MyUser userInfo;
  final bool showForgotPasswordButton;

  const CustomUserInfoForm({
    super.key,
    required this.userInfo,
    this.showForgotPasswordButton = false,
  });

  @override
  State<CustomUserInfoForm> createState() => _CustomUserInfoFormState();
}

class _CustomUserInfoFormState extends State<CustomUserInfoForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Widget> inputsWidgetsList = [];
  bool showPassword = false;

  List<Widget> getTextFields() {
    List<Widget> fieldsList = [];
    List userInfoList = widget.userInfo.toList() ?? [];

    int counter = 0;
    for (var info in userInfoList) {
      // print('user info item: ${info == '' ? '[empty]' : info}');

      if (info == null) break;

      switch (counter) {
        case 0:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 1:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 2:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 3:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 4:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 5:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        case 6:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        default:
      }

      // Add spacings
      if (counter < userInfoList.length) {
        fieldsList.add(
          const SizedBox(
            height: 20.0,
          ),
        );
      }

      counter++;
    }

    fieldsList.add(
      IconButton(
        onPressed: () => onLoginButtonPressed(),
        icon: const Icon(
          Icons.arrow_circle_right_rounded,
          size: 100.0,
        ),
      ),
    );

    return fieldsList;
  }

  Icon getVisibilityIcon() => showPassword
      ? const Icon(Icons.visibility_off_outlined)
      : const Icon(Icons.visibility_outlined);

  void togglePasswordVisibility() {
    HapticFeedback.selectionClick();

    setState(() {
      showPassword ? showPassword = false : showPassword = true;
    });
  }

  void onForgotPasswordButtonClicked() {
    HapticFeedback.lightImpact();
    // TODO: [medium priority] create functionality
  }

  /// Ordered depending on the order of [MyUser.toList()] function.
  void initWidgetsList() {
    inputsWidgetsList = [
      // Email Text Field
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => widget.userInfo.email = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Email',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          if (!value.contains('@') || !value.endsWith('.com')) {
            return 'Missing @domain.com';
          }

          return null;
        },
      ),

      // Password Text Field
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onChanged: (value) => widget.userInfo.password = value,
            obscureText: !showPassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () => togglePasswordVisibility(),
                child: getVisibilityIcon(),
              ),
              hintText: 'Password',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field cannot be left empty';
              }

              if (value.length < 6) {
                return 'Passwords should have 6 or more characters';
              }

              return null;
            },
          ),
          widget.showForgotPasswordButton
              ? const SizedBox(
                  height: 15.0,
                )
              : Container(),
          widget.showForgotPasswordButton
              ? GestureDetector(
                  onTap: () => onForgotPasswordButtonClicked(),
                  child: const Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                    style: ktsAttentionLabel,
                  ),
                )
              : Container(),
          widget.showForgotPasswordButton
              ? const SizedBox(
                  height: 30.0,
                )
              : Container(),
        ],
      ),
    ];
  }

  void onLoginButtonPressed() async {
    // ignore: todo
    // TODO: [couldn't figure out a proper way to do it, the package that I've used before is now obsolete] Display spinner when button is clicked

    HapticFeedback.selectionClick();

    bool hasInternetConnection =
        await InternetConnectionChecker().hasConnection;

    if (!hasInternetConnection) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomPopupAlerts.displayNoInternetConnection(context),
      );
      return;
    }

    if (!mounted) return;

    if (hasInternetConnection && await widget.userInfo.signIn()) {
      context.go('/tab-view-controller');
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayLoginError(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initWidgetsList();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: getTextFields(),
      ),
    );
  }
}
