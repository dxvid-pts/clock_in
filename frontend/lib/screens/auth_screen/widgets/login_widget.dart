import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/error_code.dart';
import 'package:frontend/services/auth_service.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool login = true;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (
        Widget child,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: login
          ? SingleLoginWidget(
              login: login,
              toggleLogin: () {
                setState(() {
                  login = !login;
                });
              })
          : SizedBox(
              child: SingleLoginWidget(
                  login: login,
                  toggleLogin: () {
                    setState(() {
                      login = !login;
                    });
                  }),
            ),
    );
  }
}

class SingleLoginWidget extends ConsumerStatefulWidget {
  const SingleLoginWidget({
    super.key,
    required this.login,
    this.toggleLogin,
  });

  final bool login;

  //if null -> whether a register button should be shown in login mode or a login button in register mode
  final Function()? toggleLogin;

  @override
  ConsumerState<SingleLoginWidget> createState() => _InternalLoginWidgetState();
}

class _InternalLoginWidgetState extends ConsumerState<SingleLoginWidget> {
  bool loading = false;
  ErrorCode? errorCode;
  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    bool buttonDisabled = loading || email == null || password == null;

    //if we are in login mode, we don't need a name -> extra check for registration
    if (!widget.login && name == null) {
      buttonDisabled = true;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //create account header
        Text(
          widget.login ? 'Log in to your account' : 'Create your account',
          style: const TextStyle(fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          child: Text(
              "Welcome back! Select method to ${widget.login ? "login" : "sign up"}:"),
        ),

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: ElevatedButton(
                    onPressed: () {
                      //snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Google sign in has been disabled by your company."),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*SvgPicture.asset(
                          'assets/google_g_logo.svg',
                          width: loginLogoSize,
                          height: loginLogoSize,
                        ),*/
                        SizedBox(width: 10),
                        Text("Google"),
                      ],
                    )),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Facebook sign in has been disabled by your company."),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*SvgPicture.asset(
                        'assets/facebook_logo.svg',
                        width: loginLogoSize,
                        height: loginLogoSize,
                      ),*/
                      SizedBox(width: 10),
                      Text("Facebook"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 15),
          child: Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("or continue with email"),
              ),
              Expanded(child: Divider()),
            ],
          ),
        ),

        //name input
        if (!widget.login)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              onChanged: (value) {
                bool refresh = false;

                //refresh if name is null or new name is null so the button can be en/disabled
                if (name == null) refresh = true;

                name = value.isEmpty ? null : value;

                //refresh if name is null or new name is null so the button can be en/disabled
                if (name == null) refresh = true;

                //if error is username specific, refresh to remove error
                if (errorCode?.isUsernameSpecific() ?? false) {
                  refresh = true;
                  errorCode = null;
                }

                if (refresh) setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Name',
                border: const OutlineInputBorder(),
                errorText: errorCode?.isUsernameSpecific() ?? false
                    ? errorCode?.message
                    : null,
              ),
            ),
          ),

        //email input
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              bool refresh = false;

              //refresh if email is null or new email is null so the button can be en/disabled
              if (email == null) refresh = true;

              email = value.isEmpty ? null : value;

              //refresh if email is null or new email is null so the button can be en/disabled
              if (email == null) refresh = true;

              //if error is email specific, refresh to remove error
              if (errorCode?.isEmailSpecific() ?? false) {
                refresh = true;
                errorCode = null;
              }

              if (refresh) setState(() {});
            },
            decoration: InputDecoration(
              labelText: 'Email',
              border: const OutlineInputBorder(),
              errorText: errorCode?.isEmailSpecific() ?? false
                  ? errorCode?.message
                  : null,
            ),
          ),
        ),

        //password input
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onChanged: (value) {
              bool refresh = false;

              //refresh if password is null or new password is null so the button can be en/disabled
              if (password == null) refresh = true;

              password = value.isEmpty ? null : value;

              //refresh if password is null or new password is null so the button can be en/disabled
              if (password == null) refresh = true;

              //if error is password or general specific, refresh to remove error
              //general specific, as general errors are shown on the password field
              if ((errorCode?.isPasswordSpecific() ?? false) ||
                  (errorCode?.isGeneral() ?? false)) {
                refresh = true;
                errorCode = null;
              }

              if (refresh) setState(() {});
            },
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              errorText: ((errorCode?.isPasswordSpecific() ?? false) ||
                      (errorCode?.isGeneral() ?? false))
                  ? errorCode?.message
                  : null,
            ),
          ),
        ),
        if (widget.login)
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Please reach out to your companies IT department to reset your password."),
                ),
              );
            },
            child: const Text("Forgot password?"),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 7),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: buttonDisabled
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                      });
                      //todo: evaluate input
                      ErrorCode? response;

                      if (widget.login) {
                        response =
                            await ref.read(authProvider).loginWithEmailPassword(
                                  email: email!,
                                  password: password!,
                                );
                      } else {
                        response = await ref
                            .read(authProvider)
                            .registerWithEmailPassword(
                              name: name!,
                              email: email!,
                              password: password!,
                            );
                      }

                      setState(() {
                        loading = false;
                        errorCode = response;
                      });
                    },
              child: Text(loading
                  ? "..."
                  : widget.login
                      ? "Login"
                      : "Sign up"),
            ),
          ),
        ),
        if (widget.toggleLogin != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.login
                  ? "Don't have an account?"
                  : "Already have an account?"),
              TextButton(
                onPressed: () {
                  //widget.toggleLogin!();
                  //snackbar to show that the feature is disabled
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "This feature has been disabled by your company."),
                    ),
                  );
                },
                child: Text(widget.login ? "Sign up" : "Log in"),
              ),
            ],
          ),
      ],
    );
  }
}
