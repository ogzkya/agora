import 'package:agora/screens/login_screen.dart';
import 'package:agora/screens/models/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  void _showSuccessfulMessage(String msg) {
     showDialog(context: context, builder: (ctx)=>AlertDialog(
       title: Text("Agora Sistem"),
       content: Text(msg),
       actions: <Widget>[
         //ignore: deprecated_member_use
         FlatButton(onPressed: (){
           Navigator.push(context, new MaterialPageRoute(builder:(contex)=>new LoginScreen()));



         }, child: Text("Tamamlandı"))
       ],
     ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt"),
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
                validator: (value) {

                  if(value!=null && value.isEmpty) {
                    return "mail giriniz";
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
    validator: (value) {
      if (value != null && value.isEmpty) {
        return "mail giriniz";
      }
      return null;
    }),

              SizedBox(
                height: 13,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed:() async{
                  var message = "kayıt başarılı";
                  if(!_formkey.currentState!.validate()){
                  return;
                    }
                    _formkey.currentState!.save();

                try {
                   await Provider.of<Authentication>(context, listen:false).Signup(_emailController.text, _passwordController.text);
                   _showSuccessfulMessage(message);
                } catch (error){
                throw error;
                }
                  },
                child: Text("Kayıt Ol"),


              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
