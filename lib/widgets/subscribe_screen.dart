import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/style/theme.dart' as Style;

class KayitEkrani extends StatefulWidget {
  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {

  String email,password;

  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        title: Text("Abone Olun"),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (alinanMail){
                    setState(() {
                      email = alinanMail;
                      password = alinanMail;
                    });
                  },
                  validator: (alinanMail){
                    return alinanMail.contains("@")? null : "Mail geçersiz";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Girin..",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        kayitEkle();
                      },
                    child: Text("Abone Ol"),
                    style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.roboto(
                          fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void kayitEkle(){
    if(_formAnahtari.currentState.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      Fluttertoast.showToast(msg: "Kayıt Başarılı");
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((user) {

      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
      }
  }
}
