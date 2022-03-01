import 'package:blood_donation/views/admobe_ad.dart';
import 'package:blood_donation/views/internet_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var _formKey = GlobalKey<FormState>();
  var Email;
  var cheak = false;
  AdmobeHelper admobeHelper=new AdmobeHelper();
  InternetCheck internetCheck=new InternetCheck();
  resetPasswordMethod(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        cheak = true;
      });
      var internet = await internetCheck.check();
      if(internet==true){
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        await firebaseAuth.sendPasswordResetEmail(email: Email).then((value) {
          setState(() {
            cheak = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("We sent a reset link in your mail"),
              backgroundColor: Colors.redAccent[100],
              duration: Duration(milliseconds: 300),
            ),
          );
        });
      }
      else {
        Fluttertoast.showToast(msg: "Please check your internet connection!");
        setState(() {
          cheak = true;
        });
      }

    }
  }
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-4598469579115055/6250163409',
    size: AdSize.mediumRectangle,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  @override
  void initState() {
    admobeHelper.createInerAd();
    myBanner.load();

    super.initState();
  }
  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter your account email",
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return "Empty Feild";
                              }
                            },
                            onSaved: (value) {
                              Email = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.redAccent[100],
                          child: TextButton(
                            child: !cheak
                                ? Text(
                                    "Reset Password",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Container(
                                    //height: 30,
                                    child: SpinKitWave(
                                      color: Colors.white,
                                      type: SpinKitWaveType.end,
                                    ),
                                  ),
                            onPressed: () {
                              resetPasswordMethod(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: AdWidget(ad: myBanner,))
          ],
        ),
      ),
    );
  }
}
