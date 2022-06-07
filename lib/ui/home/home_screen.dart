import 'dart:math';

import 'package:agora/ui/auth/giftScreen/gift_bloc.dart';
import 'package:agora/ui/auth/giftScreen/gift_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/constants.dart';
import 'package:agora/model/user.dart';
import 'package:agora/services/helper.dart';
import 'package:agora/ui/auth/authentication_bloc.dart';
import 'package:agora/ui/auth/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:agora/ui/auth/giftScreen/gift_bloc.dart';
import 'package:agora/ui/auth/forumScreen/wantScreen/want_screen.dart';


class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const GiftScreen(), false);
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(
                  'Menü',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(COLOR_PRIMARY),
                ),
              ),
              ListTile(
                title: const Text(
                  'Çıkış',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.exit_to_app, color: Colors.black)),
                onTap: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                },
              ),

              ListTile(
                title: const Text(
                  'Destek Talepleriniz',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.exit_to_app, color: Colors.black)),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => WantScreen())),
              ),
              ListTile(
                title: const Text(
                  'Bağış',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Transform.rotate(
                    angle: pi / 1,
                    child: const Icon(Icons.exit_to_app, color: Colors.black)),
                    onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GiftScreen())),


              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Anasayfa',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              user.profilePictureURL == ''
                  ? CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade400,
                      child: ClipOval(
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset(
                            'assets/images/pikachu.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : displayCircleImage(user.profilePictureURL, 80, false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.fullName()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.email),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.userID),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
