import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otonomus/business_logic/blocs.dart';
import 'package:otonomus/data/models/user_model.dart';
import 'package:otonomus/navigation/handle_navigation.dart';
import 'package:otonomus/presentation/shared_widgets/shared_widgets.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DrawerBloc>(context).add(CheckUser());
  }

  @override
  Widget build(BuildContext context) {
    String capitalizeEachWord(String input) {
      if (input.isEmpty) {
        return '';
      }

      List<String> words = input.split(' ');
      List<String> capitalizedWords = words.map((word) {
        if (word.isNotEmpty) {
          return word[0].toUpperCase() + word.substring(1);
        } else {
          return '';
        }
      }).toList();

      return capitalizedWords.join(' ');
    }

    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF323E48),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/1337144146/sv/vektor/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=GXVOqN9-6nUrgmK2thaQuTtf1bpxUMCEUvNlun-uX7g='),
                        radius: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${state.user.firstName.isNotEmpty ? capitalizeEachWord(state.user.firstName) : ''}'
                        ' ${state.user.lastName.isNotEmpty ? capitalizeEachWord(state.user.lastName) : ''}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'MontserratSemiBold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: CustomGlobalButton(
                  title: 'Your Profile',
                  color: Color(0xFFB2BBCA),
                  onPressed: () {},
                  width: 200,
                  height: 50,
                ),
              ),
              if (state.user == UserModel.defaultUser)
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomGlobalButton(
                    title: 'Log In',
                    color: Color(0xFFB2BBCA),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                      HandleNavigation.push('/login');
                    },
                    width: 200,
                    height: 50,
                  ),
                ),
              if (state.user != UserModel.defaultUser)
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomGlobalButton(
                    title: 'Log Out',
                    color: Color(0xFFB2BBCA),
                    onPressed: () {
                      //currentUserProvider.handleLogOut(context);
                      BlocProvider.of<DrawerBloc>(context).add(LogOut());
                      Scaffold.of(context).openEndDrawer();
                    },
                    width: 200,
                    height: 50,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
