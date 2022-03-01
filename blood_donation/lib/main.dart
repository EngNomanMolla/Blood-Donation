
import 'package:blood_donation/views/front_page.dart';
import 'package:blood_donation/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var email= sharedPreferences.getString('mail');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
     home:email==null ?FrontPage():HomePage()

  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:FrontPage(),
    );
  }
}
