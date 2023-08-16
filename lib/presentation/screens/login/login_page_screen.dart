import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:otonomus/business_logic/login/bloc/login_bloc.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/navigation/handle_navigation.dart';
import 'package:otonomus/presentation/shared_widgets/shared_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.errorMessage != '') {
          GlobalSnackbar.showError(context, state.errorMessage);
          BlocProvider.of<LoginBloc>(context).add(ClearErrorLogIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, '/home');
                                  HandleNavigation.popUntilFirst();
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 50, 30, 0),
                                  child: SvgIcon(
                                    icon: SvgIconData(
                                      'assets/icons/exitIcon.svg',
                                    ),
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(134, 90, 134, 50),
                            child: Image.asset('assets/logos/keeLogo.png'),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 40),
                            child: Text(
                              'You need to login to complete the booking process',
                              style: TextStyle(
                                color: Color(0xFF323E48),
                                fontFamily: 'MontserratRegular',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          CustomTextField(
                            title: 'Email',
                            onChanged: (email) {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginEmailChanged(email));
                            },
                            hintText: 'example@gmail.com',
                          ),
                          CustomTextFieldPassword(
                            title: 'Password',
                            onChanged: (password) {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginPasswordChanged(password));
                            },
                            hintText: '********',
                            isObscured: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                      color: Color(0xFF297BE6),
                                      fontFamily: 'MontserratRegular',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 35),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final loginBloc =
                                            BlocProvider.of<LoginBloc>(context);

                                        loginBloc.add(LoginSubmitted());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF297BE6),
                                      ),
                                      child: Text(
                                        'LOG IN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'MontserratRegular',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 110),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(
                                    fontFamily: 'MontserratRegular',
                                    fontSize: 14,
                                    color: Color(0xFF323E48),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //Navigator.pushNamed(context, '/signupmain');
                                    HandleNavigation.push('/signupmain');
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      color: Color(0xFF297BE6),
                                      fontFamily: 'MontserratSemiBold',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                state.status == LoginStatus.loading
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
