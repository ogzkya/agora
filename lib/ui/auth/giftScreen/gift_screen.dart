import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/constants.dart';
import 'package:agora/services/helper.dart';
import 'package:agora/ui/auth/authentication_bloc.dart';
import 'package:agora/ui/auth/giftScreen/gift_bloc.dart';
import 'package:agora/ui/home/home_screen.dart';
import 'package:agora/ui/loading_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({Key? key}) : super(key: key);

  @override
  State createState() => _GiftState();
}

class _GiftState extends State<GiftScreen> {
  File? _image;
  final TextEditingController  _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? firstName, lastName, password, email, city, donationtype, donationcontent, donorphone ;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  bool acceptEULA = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiftBloc>(
      create: (context) => GiftBloc(),
      child: Builder(
        builder: (context) {
          if (Platform.isAndroid) {
            context.read<GiftBloc>().add(RetrieveLostDataEvent());
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    pushAndRemoveUntil(
                        context, HomeScreen(user: state.user!), false);
                  } else {
                    showSnackBar(
                        context,
                        state.message ??
                            'Kaydolunamadı, Lütfen tekrar deneyin.');
                  }
                },
              ),

              BlocListener<GiftBloc, GiftState>(
                listener: (context, state) {
                  if (state is ValidFields) {
                    context.read<LoadingCubit>().showLoading(
                        context, 'Kayıt yapılıyor, lütfen bekleyin.', false);
                    context.read<AuthenticationBloc>().add(
                        SignupWithEmailAndPasswordEvent(
                            emailAddress: email!,
                            password: password!,
                            image: _image,
                            lastName: lastName,
                            firstName: firstName));
                  } else if (state is GiftFailureState) {
                    showSnackBar(context, state.errorMessage);
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                    color: isDarkMode(context) ? Colors.white : Colors.black),
              ),
              body: SingleChildScrollView(
                padding:
                const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: BlocBuilder<GiftBloc, GiftState>(
                  buildWhen: (old, current) =>
                  current is GiftFailureState && old != current,
                  builder: (context, state) {
                    if (state is GiftFailureState) {
                      _validate = AutovalidateMode.onUserInteraction;
                    }
                    return Form(
                      key: _key,
                      autovalidateMode: _validate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Bağış',
                            style: TextStyle(
                                color: Color(COLOR_PRIMARY),
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: validateName,
                              onSaved: (String? val) {
                                firstName = val;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: getInputDecoration(
                                  hint: 'bağışçı İsim',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: validateName,
                              onSaved: (String? val) {
                                lastName = val;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: getInputDecoration(
                                  hint: 'bağışçı soyisim',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: validateEmail,
                              onSaved: (String? val) {
                                email = val;
                              },
                              decoration: getInputDecoration(
                                  hint: 'E-posta',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              validator: validatePassword,
                              onSaved: (String? val) {
                                password = val;
                              },
                              style:
                              const TextStyle(height: 0.8, fontSize: 18.0),
                              cursorColor: const Color(COLOR_PRIMARY),
                              decoration: getInputDecoration(
                                  hint: 'Şifre',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: validateName,
                              onSaved: (String? val) {
                                donationtype = val;
                              },
                              decoration: getInputDecoration(
                                  hint: 'bağış tipi',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              validator: validatePassword,
                              onSaved: (String? val) {
                                password = val;
                              },
                              style:
                              const TextStyle(height: 0.8, fontSize: 18.0),
                              cursorColor: const Color(COLOR_PRIMARY),
                              decoration: getInputDecoration(
                                  hint: 'Telefon  ',
                                  darkMode: isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 32, right: 8, bottom: 8),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                BlocBuilder<GiftBloc, GiftState>(
                                  buildWhen: (old, current) =>
                                  current is PictureSelectedState &&
                                      old != current,
                                  builder: (context, state) {
                                    if (state is PictureSelectedState) {
                                      _image = state.imageFile;
                                    }
                                    return state is PictureSelectedState
                                        ? SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(65),
                                        child: state.imageFile == null
                                            ? Image.asset(
                                          'assets/images/',
                                          fit: BoxFit.cover,
                                        )
                                            : Image.file(
                                          state.imageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                        : SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(65),
                                        child: Image.asset(
                                          'assets/images/',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  right: 110,
                                  child: FloatingActionButton(
                                    backgroundColor: const Color(COLOR_PRIMARY),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: isDarkMode(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    mini: true,
                                    onPressed: () => _onCameraClick(context),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                right: 40.0, left: 40.0, top: 40.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(COLOR_PRIMARY),
                                padding:
                                const EdgeInsets.only(top: 12, bottom: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: const BorderSide(
                                    color: Color(COLOR_PRIMARY),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Kayıt Ol',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () => context.read<GiftBloc>().add(
                                ValidateFieldsEvent(_key,
                                    acceptEula: acceptEULA),
                              ),
                            ),
                          ),


                          const SizedBox(height: 24),
                          ListTile(
                            trailing: BlocBuilder<GiftBloc, GiftState>(
                              buildWhen: (old, current) =>
                              current is EulaToggleState && old != current,
                              builder: (context, state) {
                                if (state is EulaToggleState) {
                                  acceptEULA = state.eulaAccepted;
                                }
                                return Checkbox(
                                  onChanged: (value) =>
                                      context.read<GiftBloc>().add(
                                        ToggleEulaCheckboxEvent(
                                          eulaAccepted: value!,
                                        ),
                                      ),
                                  activeColor: const Color(COLOR_PRIMARY),
                                  value: acceptEULA,
                                );
                              },
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text:
                                    'Sözleşme şartlarını okuyup, onayladığımı beyan ederim\n',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                    ),
                                    text: 'Kullanım Şartları',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (await canLaunch(EULA)) {
                                          await launch(
                                            EULA,
                                            forceSafariVC: false,
                                          );
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onCameraClick(BuildContext context) {
    final action = CupertinoActionSheet(
      title: const Text(
        'Profil Resmi Ekle',
        style: TextStyle(fontSize: 15.0),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Galeriden Seç'),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            context.read<GiftBloc>().add(ChooseImageFromGalleryEvent());
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Bir fotoğraf çek'),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            context.read<GiftBloc>().add(CaptureImageByCameraEvent());
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
          child: const Text('İptal'), onPressed: () => Navigator.pop(context)),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();
  }
}
