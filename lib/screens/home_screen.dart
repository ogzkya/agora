import 'package:agora/screens/login_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
        actions: [IconButton(onPressed: (){
          Navigator.push(context,new MaterialPageRoute(builder: (context)=>new LoginScreen()));
        }, icon: Icon(Icons.logout_sharp))],
      ),

      body: Center(child: Text("Girişiniz Başarılı"),
      ),
    );

  }
}
