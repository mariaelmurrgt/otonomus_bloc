import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:otonomus/business_logic/blocs.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/navigation/handle_navigation.dart';
import 'package:otonomus/presentation/shared_widgets/shared_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.errorMessage != '') {
          GlobalSnackbar.showError(context, state.errorMessage);
          BlocProvider.of<SignupBloc>(context).add(ClearErrorSignUp());
        }
        if (state.status == SignupStatus.success) {
          BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationStatusChanged(AuthenticationStatus.authenticated));
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  color: Color(0xFFF9F9F9),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(25, 80, 10, 40),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HandleNavigation.pop();
                                  },
                                  child: SvgIcon(
                                    icon: SvgIconData(
                                      'assets/icons/backArrowIcon.svg',
                                    ),
                                    size: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 125,
                                ),
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF323E48),
                                    fontFamily: 'MontserratMedium',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            title: 'Email',
                            hintText: 'example@gmail.com',
                            onChanged: (email) {
                              BlocProvider.of<SignupBloc>(context)
                                  .add(SignupEmailChanged(email));
                            },
                          ),
                          CustomTextField(
                            title: 'First Name',
                            hintText: 'John',
                            onChanged: (firstName) {
                              BlocProvider.of<SignupBloc>(context)
                                  .add(SignupFirstNameChanged(firstName));
                            },
                          ),
                          CustomTextField(
                            title: 'Last Name',
                            hintText: 'Doe',
                            onChanged: (lastName) {
                              BlocProvider.of<SignupBloc>(context)
                                  .add(SignupLastNameChanged(lastName));
                            },
                          ),
                          CustomTextFieldPassword(
                            title: 'Password',
                            hintText: '********',
                            isObscured: true,
                            onChanged: (password) {
                              BlocProvider.of<SignupBloc>(context)
                                  .add(SignupPasswordChanged(password));
                            },
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Password should contain at least 1 letter uppercase and a total of 8 characters.',
                                      style: TextStyle(
                                        fontFamily: 'MontserratRegular',
                                        fontSize: 10,
                                        color: Color(0xFF323E48),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 45, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final signupBloc =
                                            BlocProvider.of<SignupBloc>(
                                                context);

                                        signupBloc.add(SignUpSubmitted());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF297BE6),
                                      ),
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                state.status == SignupStatus.loading
                    ? CustomLoadingWidget()
                    : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
