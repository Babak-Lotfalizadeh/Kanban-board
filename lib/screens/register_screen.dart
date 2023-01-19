import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/enums/firebase_login_error_enum.dart';
import 'package:kanban_board/enums/text_field_rule.dart';
import 'package:kanban_board/providers/register_provider.dart';
import 'package:kanban_board/screens/login_screen.dart';
import 'package:kanban_board/screens/splash_screen.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/services/snack_bar_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/authentication/authentication_content_widget.dart';
import 'package:kanban_board/widgets/base/base_constraint_scaffold.dart';
import 'package:kanban_board/widgets/button_widget.dart';
import 'package:kanban_board/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  Future<void> _onRegister(
    BuildContext context,
    RegisterProvider registerProvider,
  ) async {
    var pass = registerProvider.formKey.currentState?.validate();
    if (pass == false) {
      return;
    }
    await registerProvider.register(
      whenSuccess: () {
        NavigationService.pushAndReplace(const SplashScreen());
      },
      whenError: (response) {
        _showError(context, response);
      },
    );
  }

  void _showError(BuildContext context, String response) {
    var strings = AppLocalizations.of(context);
    var error = strings?.unknownError;
    if (response == FirebaseLoginErrorEnum.userNotFound.code) {
      error = strings?.userNotFound;
    } else if (response == FirebaseLoginErrorEnum.wrongPassword.code) {
      error = strings?.wrongPassword;
    }
    SnackBarService.show(message: error, context: context);
  }

  void _goLogin() {
    NavigationService.pushAndReplace(const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) => BaseConstraintScaffold(
          body: AuthenticationContentWidget(
            title: strings?.register,
            formKey: registerProvider.formKey,
            contents: [
              TextFieldWidget(
                labelText: strings?.userName,
                focusNode: registerProvider.userNameFocusNode,
                controller: registerProvider.userNameController,
                textFieldRule: TextFieldRule.email,
                prefixIcon: const Icon(Icons.account_box),
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.password,
                focusNode: registerProvider.passwordFocusNode,
                controller: registerProvider.passwordController,
                textFieldRule: TextFieldRule.password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.passwordConfirm,
                focusNode: registerProvider.confirmFocusNode,
                controller: registerProvider.confirmController,
                prefixIcon: const Icon(Icons.lock),
                textFieldRule: TextFieldRule.password,
                validator: (input) {
                  if (input != registerProvider.passwordController.text) {
                    return strings?.passwordAndPasswordConfirmValueIsNotMatch;
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingXLarge),
              ButtonWidget(
                title: strings?.register ?? "",
                onPressed: () async => await _onRegister(
                  context,
                  registerProvider,
                ),
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.all(ScreenValues.paddingXLarge),
              child: InkWell(
                onTap: _goLogin,
                child: Column(
                  children: [
                    Text(
                      strings?.alreadyHaveAnAccount ?? "",
                    ),
                    Text(
                      strings?.login ?? "",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
