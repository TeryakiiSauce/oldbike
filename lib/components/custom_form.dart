///
/// This file is responsible for displaying the user sign in & registration forms.
/// === === === === ===

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

  /// Used to either create an new account or login.
  final bool isLoginForm;

  const CustomUserInfoForm({
    super.key,
    required this.userInfo,
    this.showForgotPasswordButton = false,
    this.isLoginForm = true,
  });

  @override
  State<CustomUserInfoForm> createState() => _CustomUserInfoFormState();
}

class _CustomUserInfoFormState extends State<CustomUserInfoForm> {
  /// Mainly used to check if there are any invalid fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Used to add the Text Fields
  List<Widget> inputsWidgetsList = [];

  bool showPassword = false;

  /// Checks what user info has been passed to this widget and creates whatever input fields needed.
  /// If some user info is null, an input field will NOT be created.
  ///
  /// **Returns** A list of the input fields widgets.
  List<Widget> getTextFields() {
    List<Widget> fieldsList = [];
    List userInfoList = widget.userInfo.toList() ?? [];

    int counter = 0;

    /// Loops around all user information and checks whether an input field needs to be created or not.
    for (var info in userInfoList) {
      if (info == null) break;

      switch (counter) {
        // Email
        case 0:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Password
        case 1:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // First Name
        case 2:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Last Name
        case 3:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Blood Group
        case 4:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Gender
        case 5:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Height
        case 6:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Weight
        case 7:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
        // Date of Birth
        case 8:
          fieldsList.add(inputsWidgetsList[counter]);
          break;
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

    // Adds a button with either a login or register functionality.
    fieldsList.add(
      IconButton(
        onPressed: () => widget.isLoginForm
            ? onLoginButtonPressed()
            : onSignUpButtonPressed(),
        icon: const Icon(
          Icons.arrow_circle_right_rounded,
          size: 100.0,
        ),
      ),
    );

    return fieldsList;
  }

  /// Password visibility icon
  Icon getVisibilityIcon() => showPassword
      ? const Icon(Icons.visibility_off_outlined)
      : const Icon(Icons.visibility_outlined);

  /// Toggles password visibility icon
  void togglePasswordVisibility() {
    HapticFeedback.selectionClick();

    setState(() {
      showPassword ? showPassword = false : showPassword = true;
    });
  }

  /// [Deprecated]
  @Deprecated('Functionality removed because it takes time')
  void onForgotPasswordButtonClicked() {
    HapticFeedback.lightImpact();
    // ignore: todo
    // TODO: [medium priority] create functionality; requires checking is email is verified.
  }

  /// Creates a new list of all input fields that might be used.
  /// Note: Ordered depending on the order of [MyUser.toList()] function.
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

      // First Name Field
      TextFormField(
        onChanged: (value) => widget.userInfo.firstName = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.android_rounded),
          hintText: 'First Name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          if (value.contains(' ')) {
            return 'Field cannot contain spaces';
          }

          return null;
        },
      ),

      // Last Name Field
      TextFormField(
        onChanged: (value) => widget.userInfo.lastName = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.assignment_ind_rounded),
          hintText: 'Last Name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          if (value.contains(' ')) {
            return 'Field cannot contain spaces';
          }

          return null;
        },
      ),

      // Blood Group Field
      TextFormField(
        onChanged: (value) => widget.userInfo.bloodGroup = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.water_drop_rounded),
          hintText: 'Blood Group',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          String tempStr = value.toUpperCase();

          if (tempStr != 'O' &&
              tempStr != 'A' &&
              tempStr != 'B' &&
              tempStr != 'AB') {
            return 'Field only accepts: O, A, B, and AB';
          }

          return null;
        },
      ),

      // Gender Field
      TextFormField(
        onChanged: (value) => widget.userInfo.gender = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.badge_rounded),
          hintText: 'Gender',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          String tempStr = value.toLowerCase();

          if (tempStr != 'male' && tempStr != 'female' && tempStr != 'alien') {
            return 'Field only accepts: Male, Female or Alien';
          }

          return null;
        },
      ),

      // Height Field
      TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isEmpty) return;
          widget.userInfo.height = double.parse(value);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.height_rounded),
          hintText: 'Height (in Centimetres)',
          suffix: Text('CM'),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          return null;
        },
      ),

      // Weight Field
      TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isEmpty) return;
          widget.userInfo.weight = double.parse(value);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.monitor_weight_rounded),
          hintText: 'Weight (in Kilograms)',
          suffix: Text('KG'),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          return null;
        },
      ),

      // Date of Birth Field
      TextFormField(
        keyboardType: TextInputType.datetime,
        onChanged: (value) => widget.userInfo.dob = DateTime.tryParse(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.date_range_rounded),
          hintText: 'Date of Birth',
          suffix: Text('YYYY-MM-DD'),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be left empty';
          }

          if (widget.userInfo.dob == null) {
            return 'Invalid or incomplete date';
          }

          return null;
        },
      ),
    ];
  }

  /// Checks if input fields are valid, has internet connection and then signs the user in
  /// and redirects them to the app's home screen.
  void onLoginButtonPressed() async {
    // ignore: todo
    // TODO: [couldn't figure out a proper way to do it, the package that I've used before is now obsolete] Display spinner when button is clicked

    HapticFeedback.selectionClick();

    // Checks input fields validity
    if (!formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayInvalid(context),
      );
      return;
    }

    if (!await InternetConnectionChecker().hasConnection) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomPopupAlerts.displayNoInternetConnection(context),
      );
      return;
    }

    if (!mounted) return;

    if (await InternetConnectionChecker().hasConnection &&
        await widget.userInfo.signIn()) {
      context.go('/tab-view-controller');
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayLoginError(context),
      );
    }
  }

  /// Checks if input fields are valid, has internet connection and then registers a new account
  /// and later redirects them to the app's home screen.
  void onSignUpButtonPressed() async {
    HapticFeedback.selectionClick();

    // Checks input fields validity
    if (!formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayInvalid(context),
      );
      return;
    }

    final String error = await widget.userInfo.createUser();

    if (!await InternetConnectionChecker().hasConnection) {
      showDialog(
        context: context,
        builder: (context) =>
            CustomPopupAlerts.displayNoInternetConnection(context),
      );
      return;
    }

    // Gets the error message (if any) and displays it as an alert
    if (error != '') {
      await showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayRegistrationError(
          context,
          error,
        ),
      );
      return;
    }

    await widget.userInfo.uploadUserInfo();
    if (!mounted) return;
    context.pop();
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
