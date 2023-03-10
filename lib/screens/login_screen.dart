import 'package:flutter/material.dart';
import 'package:kanban_board/constants/screen_values.dart';
import 'package:kanban_board/enums/firebase_login_error_enum.dart';
import 'package:kanban_board/enums/text_field_rule.dart';
import 'package:kanban_board/providers/login_provider.dart';
import 'package:kanban_board/screens/register_screen.dart';
import 'package:kanban_board/screens/splash_screen.dart';
import 'package:kanban_board/services/navigation_service.dart';
import 'package:kanban_board/services/snack_bar_service.dart';
import 'package:kanban_board/utilities/imports.dart';
import 'package:kanban_board/widgets/authentication/authentication_content_widget.dart';
import 'package:kanban_board/widgets/base/base_constraint_scaffold.dart';
import 'package:kanban_board/widgets/button_widget.dart';
import 'package:kanban_board/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> _onLogin(
    BuildContext context,
    LoginProvider loginProvider,
  ) async {
    var pass = loginProvider.formKey.currentState?.validate();
    if (pass == false) {
      return;
    }
    await loginProvider.login(
      whenSuccess: () {
        NavigationService.pushAndReplace(const SplashScreen());
      },
      whenError: (response) => _showError(context, response),
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

  void _goRegister() {
    NavigationService.pushAndReplace(const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) => BaseConstraintScaffold(
          body: AuthenticationContentWidget(
            title: strings?.login,
            formKey: loginProvider.formKey,
            contents: [
              TextFieldWidget(
                labelText: strings?.userName,
                focusNode: loginProvider.userNameFocusNode,
                controller: loginProvider.userNameController,
                textFieldRule: TextFieldRule.email,
                prefixIcon: const Icon(Icons.account_box),
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.password,
                focusNode: loginProvider.passwordFocusNode,
                controller: loginProvider.passwordController,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingNormal),
              ButtonWidget(
                title: strings?.login ?? "",
                onPressed: () async => await _onLogin(context, loginProvider),
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.all(ScreenValues.paddingXLarge),
              child: InkWell(
                onTap: _goRegister,
                child: Column(
                  children: [
                    Text(
                      strings?.doNotHaveAnAccount ?? "",
                    ),
                    Text(
                      strings?.createAccount ?? "",
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
