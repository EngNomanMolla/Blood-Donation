
import 'package:blood_donation/views/sign_in.dart';
import 'package:blood_donation/views/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class FrontPage extends StatefulWidget {
  const FrontPage() : super();

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final BannerAd myBanner = BannerAd(
    adUnitId:'ca-app-pub-4598469579115055/6250163409',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

@override
  void initState() {
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
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,

                child:Container(
                  padding: EdgeInsets.fromLTRB(0, height*0.1-10, 0, 0),
                  height: height*0.3,
                  width: width*0.3,
                  child: Image.asset("images/bloodpic.png")
                )),

            Expanded(
                flex: 2,

                child:Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: width*0.5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0.0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(width: 1.5, color: Colors.red),
                                  )),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.redAccent)),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.lato(fontSize: 20,color:Colors.white)
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignUp()));
                          },
                        ),
                      ),
                      Container(
                        width: width*0.5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0.0),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(width: 1.5, color: Colors.red),
                                  )),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.transparent)),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.lato(fontSize: 20,color:Colors.red)
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignIn()));
                          },
                        ),
                      ),
                    ],
                  ),

                )),
            Expanded(
                flex: 1,

                child:Container(
                  child: AdWidget(ad: myBanner,)
                  ))
          ],
        ),
      ),


    );
  }
}
