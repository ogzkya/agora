import 'package:agora/screens/home_screen.dart';
import 'package:agora/screens/models/authentication.dart';
import 'package:agora/screens/singup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void _showfailedfulMessage(String msg) {
    showDialog(context: context, builder: (ctx)=>AlertDialog(
      title: Text("Agora Sistem"),
      content: Text(msg),
      actions: <Widget>[
        //ignore: deprecated_member_use
        FlatButton(onPressed: (){
          Navigator.pop(context);



        }, child: Text("Başarısız"))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
        actions: [IconButton(onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context)=>new SignupScreen()));
        }, icon: Icon(Icons.login_sharp))],
      ),

      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Mail Adresi"
                  ),
                  validator: (value){
                    if(value!=null && value.isEmpty){
                      return "mail gir";
                    }
                    return null;
                  },

                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  controller: _passwordController,

                  decoration: InputDecoration(
                    hintText: "Parola"
                  ),

                  validator: (value){
                    if(value!=null && value.isEmpty){
                      return "Şifre Gir";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 13,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed:() async{
                    if(!_formkey.currentState!.validate()){
                      return;
                    }
                    _formkey.currentState!.save();
                    try{
                      await Provider.of<Authentication>(context, listen:false).LogIn(_emailController.text, _passwordController.text);
                      Navigator.push(context,new MaterialPageRoute(builder: (context)=> new HomeScreen()));
                    } catch(error){
                      var errorMessage = "Giriş Başarısız, Tekrar Deneyin";
                      _showfailedfulMessage(errorMessage);
                    }
                  },
                  child: Text("Giriş"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
